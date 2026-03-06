import { useState, useRef, useCallback, useEffect } from 'react';
import { generateSpeech, generateMultiSpeakerSpeech } from '../lib/geminiTts';
import type { SpeakerConfig } from '../lib/geminiTts';
import type { StoryScene } from '../lib/database.types';
import type { StoryLang } from './useStoryLanguage';

export type TtsStatus = 'idle' | 'loading' | 'playing' | 'paused' | 'error';

interface UseTtsReturn {
  status: TtsStatus;
  currentSceneIndex: number;
  errorMessage: string | null;
  play: () => void;
  pause: () => void;
  stop: () => void;
}

// ─── Multi-speaker content parsing (mirrors generate-tts-cache.mjs logic) ────

const NARRATOR_VOICE = 'Kore';

interface TtsSegment {
  speaker: string;
  text: string;
}

interface TtsChunk {
  speakers: SpeakerConfig[];
  text: string; // For multi-speaker: "Speaker: text" format. For single: plain text.
  isMultiSpeaker: boolean;
}

function parseContentToSegments(content: string): TtsSegment[] {
  const cleaned = content.replace(/\{\{image:[^}]+\}\}/g, '').trim();
  const paragraphs = cleaned.split('\n\n');
  const segments: TtsSegment[] = [];

  for (const para of paragraphs) {
    const trimmed = para.trim();
    if (!trimmed) continue;

    const tagMatch = trimmed.match(/^\{\{speaker:([^}]+)\}\}\n?(.*)$/s);
    if (tagMatch) {
      const text = tagMatch[2].trim();
      if (text) segments.push({ speaker: tagMatch[1], text });
    } else {
      segments.push({ speaker: NARRATOR_VOICE, text: trimmed });
    }
  }
  return segments;
}

function groupIntoChunks(segments: TtsSegment[]): TtsSegment[][] {
  if (segments.length === 0) return [];

  const chunks: TtsSegment[][] = [];
  let currentChunk: TtsSegment[] = [];
  let currentCharacter: string | null = null;

  for (const seg of segments) {
    if (seg.speaker === NARRATOR_VOICE) {
      currentChunk.push(seg);
    } else {
      if (currentCharacter !== null && currentCharacter !== seg.speaker) {
        const trailingNarration: TtsSegment[] = [];
        while (
          currentChunk.length > 0 &&
          currentChunk[currentChunk.length - 1].speaker === NARRATOR_VOICE
        ) {
          trailingNarration.unshift(currentChunk.pop()!);
        }
        if (currentChunk.length > 0) chunks.push(currentChunk);
        currentChunk = [...trailingNarration, seg];
      } else {
        currentChunk.push(seg);
      }
      currentCharacter = seg.speaker;
    }
  }
  if (currentChunk.length > 0) chunks.push(currentChunk);
  return chunks;
}

function prepareSceneForTts(scene: StoryScene, lang: StoryLang): TtsChunk[] {
  const title = lang === 'en' && scene.title_en ? scene.title_en : scene.title;
  const content = lang === 'en' && scene.content_en ? scene.content_en : scene.content;

  const titleSegments: TtsSegment[] = title ? [{ speaker: NARRATOR_VOICE, text: title }] : [];
  const contentSegments = parseContentToSegments(content);
  const allSegments = [...titleSegments, ...contentSegments];

  if (allSegments.length === 0) return [];

  const rawChunks = groupIntoChunks(allSegments);

  return rawChunks.map((chunk) => {
    const speakers = [...new Set(chunk.map((s) => s.speaker))];
    const isMultiSpeaker = speakers.length >= 2;

    return {
      speakers: speakers.map((s) => ({ speaker: s, voiceName: s })),
      text: isMultiSpeaker
        ? chunk.map((s) => `${s.speaker}: ${s.text}`).join('\n')
        : chunk.map((s) => s.text).join('\n'),
      isMultiSpeaker,
    };
  });
}

/**
 * Try to fetch pre-cached audio from Supabase Storage.
 * Returns a Blob if found, null otherwise.
 */
const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL as string;
const TTS_CACHE_BUCKET = 'tts-cache';

async function fetchCachedAudio(
  scene: StoryScene,
  lang: StoryLang,
  signal?: AbortSignal
): Promise<Blob | null> {
  const ext = 'wav';
  const langPrefix = lang === 'en' ? 'en' : 'ja';
  const url = `${SUPABASE_URL}/storage/v1/object/public/${TTS_CACHE_BUCKET}/${langPrefix}/ch${scene.chapter_id}/scene${scene.scene_number}.${ext}`;

  try {
    const res = await fetch(url, { signal });
    if (res.ok) {
      return await res.blob();
    }
  } catch {
    // Cache miss or network error — fall through
  }
  return null;
}

export function useTts(scenes: StoryScene[], lang: StoryLang = 'ja'): UseTtsReturn {
  const [status, setStatus] = useState<TtsStatus>('idle');
  const [currentSceneIndex, setCurrentSceneIndex] = useState(0);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const audioRef = useRef<HTMLAudioElement | null>(null);
  const abortRef = useRef<AbortController | null>(null);
  const objectUrlRef = useRef<string | null>(null);
  const statusRef = useRef<TtsStatus>('idle');
  const prefetchRef = useRef<AbortController | null>(null);

  const revokeUrl = useCallback(() => {
    if (objectUrlRef.current) {
      URL.revokeObjectURL(objectUrlRef.current);
      objectUrlRef.current = null;
    }
  }, []);

  // Keep statusRef in sync
  const updateStatus = useCallback((newStatus: TtsStatus) => {
    statusRef.current = newStatus;
    setStatus(newStatus);
  }, []);

  const prefetchScene = useCallback(
    (index: number) => {
      if (index >= scenes.length) return;

      prefetchRef.current?.abort();
      const controller = new AbortController();
      prefetchRef.current = controller;

      // Prefetch: try a simple single-speaker generation for the first chunk
      const chunks = prepareSceneForTts(scenes[index], lang);
      if (chunks.length > 0) {
        const first = chunks[0];
        if (first.isMultiSpeaker) {
          generateMultiSpeakerSpeech(first.text, first.speakers, {
            signal: controller.signal,
          }).catch(() => {});
        } else {
          generateSpeech(first.text, {
            voiceName: first.speakers[0]?.voiceName,
            signal: controller.signal,
          }).catch(() => {});
        }
      }
    },
    [scenes, lang]
  );
  const playScene = useCallback(
    async (index: number) => {
      if (index >= scenes.length) {
        updateStatus('idle');
        setCurrentSceneIndex(0);
        return;
      }

      // Abort any ongoing request and create a fresh controller
      abortRef.current?.abort();
      abortRef.current = null;
      const controller = new AbortController();
      abortRef.current = controller;

      setCurrentSceneIndex(index);
      updateStatus('loading');
      setErrorMessage(null);

      try {
        // 1) Try pre-cached audio from Supabase Storage
        let wavBlob = await fetchCachedAudio(scenes[index], lang, controller.signal);

        // 2) Fall back to real-time TTS generation (multi-speaker aware)
        if (!wavBlob) {
          const chunks = prepareSceneForTts(scenes[index], lang);

          if (chunks.length === 0) {
            // Nothing to play — skip to next scene
            playScene(index + 1);
            return;
          }

          if (chunks.length === 1 && !chunks[0].isMultiSpeaker) {
            // Single chunk, single speaker — use simple path
            wavBlob = await generateSpeech(chunks[0].text, {
              voiceName: chunks[0].speakers[0]?.voiceName,
              signal: controller.signal,
            });
          } else {
            // Multi-chunk or multi-speaker — generate each chunk and concatenate
            const blobParts: Blob[] = [];
            for (const chunk of chunks) {
              if (controller.signal.aborted) return;
              let chunkBlob: Blob;
              if (chunk.isMultiSpeaker) {
                chunkBlob = await generateMultiSpeakerSpeech(chunk.text, chunk.speakers, {
                  signal: controller.signal,
                });
              } else {
                chunkBlob = await generateSpeech(chunk.text, {
                  voiceName: chunk.speakers[0]?.voiceName,
                  signal: controller.signal,
                });
              }
              blobParts.push(chunkBlob);
            }

            if (controller.signal.aborted) return;

            // Concatenate WAV blobs by extracting PCM data (skip 44-byte headers)
            const pcmArrays: Uint8Array[] = [];
            for (const blob of blobParts) {
              const buf = new Uint8Array(await blob.arrayBuffer());
              pcmArrays.push(buf.slice(44)); // skip WAV header
            }
            const totalLen = pcmArrays.reduce((s, a) => s + a.length, 0);
            const combined = new Uint8Array(totalLen);
            let offset = 0;
            for (const arr of pcmArrays) {
              combined.set(arr, offset);
              offset += arr.length;
            }

            // Build new WAV with combined PCM
            const header = new ArrayBuffer(44);
            const view = new DataView(header);
            const writeStr = (o: number, s: string) => {
              for (let i = 0; i < s.length; i++) view.setUint8(o + i, s.charCodeAt(i));
            };
            writeStr(0, 'RIFF');
            view.setUint32(4, 36 + combined.length, true);
            writeStr(8, 'WAVE');
            writeStr(12, 'fmt ');
            view.setUint32(16, 16, true);
            view.setUint16(20, 1, true);
            view.setUint16(22, 1, true); // mono
            view.setUint32(24, 24000, true); // sample rate
            view.setUint32(28, 48000, true); // byte rate
            view.setUint16(32, 2, true); // block align
            view.setUint16(34, 16, true); // bits per sample
            writeStr(36, 'data');
            view.setUint32(40, combined.length, true);

            wavBlob = new Blob([header, combined], { type: 'audio/wav' });
          }
        }

        if (controller.signal.aborted) return;

        prefetchScene(index + 1);

        revokeUrl();
        const url = URL.createObjectURL(wavBlob);
        objectUrlRef.current = url;

        const audio = new Audio(url);
        audioRef.current = audio;

        audio.onended = () => {
          playScene(index + 1);
        };

        audio.onerror = () => {
          setStatus('error');
          setErrorMessage('Audio playback failed');
        };

        await audio.play();
        updateStatus('playing');
      } catch (err: unknown) {
        if (err instanceof DOMException && err.name === 'AbortError') return;
        // If stop() was called while we were loading, don't overwrite 'idle' with 'error'
        if (statusRef.current === 'idle') return;
        const msg = err instanceof Error ? err.message : 'TTS generation failed';
        updateStatus('error');
        setErrorMessage(msg);
      }
    },
    [scenes, revokeUrl, updateStatus, prefetchScene]
  );

  const play = useCallback(() => {
    const currentStatus = statusRef.current;
    if (currentStatus === 'paused' && audioRef.current) {
      audioRef.current.play();
      updateStatus('playing');
      return;
    }

    if (currentStatus === 'idle' || currentStatus === 'error') {
      playScene(currentSceneIndex);
    }
  }, [currentSceneIndex, playScene, updateStatus]);

  const pause = useCallback(() => {
    if (audioRef.current && status === 'playing') {
      audioRef.current.pause();
      setStatus('paused');
    }
  }, [status]);

  const stop = useCallback(() => {
    abortRef.current?.abort();
    abortRef.current = null;
    prefetchRef.current?.abort();
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.onended = null;
      audioRef.current.onerror = null;
      audioRef.current = null;
    }
    revokeUrl();
    updateStatus('idle');
    setCurrentSceneIndex(0);
    setErrorMessage(null);
  }, [revokeUrl, updateStatus]);

  useEffect(() => {
    return () => {
      abortRef.current?.abort();
      prefetchRef.current?.abort();
      if (audioRef.current) {
        audioRef.current.pause();
        audioRef.current.onended = null;
        audioRef.current.onerror = null;
      }
      if (objectUrlRef.current) {
        URL.revokeObjectURL(objectUrlRef.current);
      }
    };
  }, []);

  useEffect(() => {
    stop();
  }, [scenes, lang, stop]);

  return {
    status,
    currentSceneIndex,
    errorMessage,
    play,
    pause,
    stop,
  };
}
