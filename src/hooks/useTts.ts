import { useState, useRef, useCallback, useEffect } from 'react';
import { generateSpeech } from '../lib/geminiTts';
import type { StoryScene } from '../lib/database.types';

export type TtsStatus = 'idle' | 'loading' | 'playing' | 'paused' | 'error';

interface UseTtsReturn {
  /** Current playback status */
  status: TtsStatus;
  /** Index of the scene currently being played / loaded */
  currentSceneIndex: number;
  /** Error message if status is 'error' */
  errorMessage: string | null;
  /** Start or resume playback */
  play: () => void;
  /** Pause playback */
  pause: () => void;
  /** Stop playback and reset */
  stop: () => void;
}

export function useTts(scenes: StoryScene[]): UseTtsReturn {
  const [status, setStatus] = useState<TtsStatus>('idle');
  const [currentSceneIndex, setCurrentSceneIndex] = useState(0);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const audioRef = useRef<HTMLAudioElement | null>(null);
  const abortRef = useRef<AbortController | null>(null);
  const objectUrlRef = useRef<string | null>(null);

  // Cleanup object URL to avoid memory leaks
  const revokeUrl = useCallback(() => {
    if (objectUrlRef.current) {
      URL.revokeObjectURL(objectUrlRef.current);
      objectUrlRef.current = null;
    }
  }, []);

  // Generate and play audio for a given scene index
  const playScene = useCallback(
    async (index: number) => {
      if (index >= scenes.length) {
        setStatus('idle');
        setCurrentSceneIndex(0);
        return;
      }

      // Abort any ongoing request
      abortRef.current?.abort();
      const controller = new AbortController();
      abortRef.current = controller;

      setCurrentSceneIndex(index);
      setStatus('loading');
      setErrorMessage(null);

      try {
        const scene = scenes[index];
        const textToSpeak = [scene.title, scene.content].filter(Boolean).join('\n\n');

        const wavBlob = await generateSpeech(textToSpeak, {
          signal: controller.signal,
        });

        // If aborted while waiting, bail out
        if (controller.signal.aborted) return;

        revokeUrl();
        const url = URL.createObjectURL(wavBlob);
        objectUrlRef.current = url;

        const audio = new Audio(url);
        audioRef.current = audio;

        audio.onended = () => {
          // Automatically advance to next scene
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
    [scenes, revokeUrl]
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

  // Cleanup on unmount or scenes change
  useEffect(() => {
    return () => {
      abortRef.current?.abort();
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

  // Reset when scenes change
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
