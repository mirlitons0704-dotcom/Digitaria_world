import { useState, useRef, useCallback, useEffect } from 'react';
import { generateSpeech } from '../lib/geminiTts';
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

function sceneToText(scene: StoryScene, lang: StoryLang): string {
  const title = lang === 'en' && scene.title_en ? scene.title_en : scene.title;
  const content = lang === 'en' && scene.content_en ? scene.content_en : scene.content;
  const rawText = [title, content].filter(Boolean).join('\n\n');
  return rawText.replace(/\{\{image:[^}]+\}\}/g, '');
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

      const text = sceneToText(scenes[index], lang);
      generateSpeech(text, { signal: controller.signal }).catch(() => {});
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

        // 2) Fall back to real-time TTS generation
        if (!wavBlob) {
          const text = sceneToText(scenes[index], lang);
          wavBlob = await generateSpeech(text, {
            signal: controller.signal,
          });
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
