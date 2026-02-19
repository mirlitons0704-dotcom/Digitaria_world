import { useState, useRef, useCallback, useEffect } from 'react';
import { generateSpeech } from '../lib/geminiTts';
import type { StoryScene } from '../lib/database.types';

export type TtsStatus = 'idle' | 'loading' | 'playing' | 'paused' | 'error';

interface UseTtsReturn {
  status: TtsStatus;
  currentSceneIndex: number;
  errorMessage: string | null;
  play: () => void;
  pause: () => void;
  stop: () => void;
}

function sceneToText(scene: StoryScene): string {
  const rawText = [scene.title, scene.content].filter(Boolean).join('\n\n');
  return rawText.replace(/\{\{image:[^}]+\}\}/g, '');
}

export function useTts(scenes: StoryScene[]): UseTtsReturn {
  const [status, setStatus] = useState<TtsStatus>('idle');
  const [currentSceneIndex, setCurrentSceneIndex] = useState(0);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const audioRef = useRef<HTMLAudioElement | null>(null);
  const abortRef = useRef<AbortController | null>(null);
  const objectUrlRef = useRef<string | null>(null);
  const prefetchRef = useRef<AbortController | null>(null);

  const revokeUrl = useCallback(() => {
    if (objectUrlRef.current) {
      URL.revokeObjectURL(objectUrlRef.current);
      objectUrlRef.current = null;
    }
  }, []);

  const prefetchScene = useCallback(
    (index: number) => {
      if (index >= scenes.length) return;

      prefetchRef.current?.abort();
      const controller = new AbortController();
      prefetchRef.current = controller;

      const text = sceneToText(scenes[index]);
      generateSpeech(text, { signal: controller.signal }).catch(() => {});
    },
    [scenes],
  );

  const playScene = useCallback(
    async (index: number) => {
      if (index >= scenes.length) {
        setStatus('idle');
        setCurrentSceneIndex(0);
        return;
      }

      abortRef.current?.abort();
      const controller = new AbortController();
      abortRef.current = controller;

      setCurrentSceneIndex(index);
      setStatus('loading');
      setErrorMessage(null);

      try {
        const text = sceneToText(scenes[index]);

        const wavBlob = await generateSpeech(text, {
          signal: controller.signal,
        });

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
        setStatus('playing');
      } catch (err: unknown) {
        if (err instanceof DOMException && err.name === 'AbortError') return;
        const msg = err instanceof Error ? err.message : 'TTS generation failed';
        setStatus('error');
        setErrorMessage(msg);
      }
    },
    [scenes, revokeUrl, prefetchScene],
  );

  const play = useCallback(() => {
    if (status === 'paused' && audioRef.current) {
      audioRef.current.play();
      setStatus('playing');
      return;
    }

    if (status === 'idle' || status === 'error') {
      playScene(currentSceneIndex);
    }
  }, [status, currentSceneIndex, playScene]);

  const pause = useCallback(() => {
    if (audioRef.current && status === 'playing') {
      audioRef.current.pause();
      setStatus('paused');
    }
  }, [status]);

  const stop = useCallback(() => {
    abortRef.current?.abort();
    prefetchRef.current?.abort();
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.onended = null;
      audioRef.current.onerror = null;
      audioRef.current = null;
    }
    revokeUrl();
    setStatus('idle');
    setCurrentSceneIndex(0);
    setErrorMessage(null);
  }, [revokeUrl]);

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
  }, [scenes, stop]);

  return {
    status,
    currentSceneIndex,
    errorMessage,
    play,
    pause,
    stop,
  };
}
