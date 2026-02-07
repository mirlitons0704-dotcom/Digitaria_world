import { useState, useRef, useEffect, useCallback } from 'react';
import {
  Play,
  Pause,
  Volume2,
  Gauge,
  Hand,
  ChevronsDown,
} from 'lucide-react';
import type { StoryScene } from '../lib/database.types';

interface StoryTeleprompterProps {
  scenes: StoryScene[];
  chapterTitle: string;
}

const SPEED_OPTIONS = [
  { label: 'Slow', value: 0.5 },
  { label: 'Normal', value: 1 },
  { label: 'Fast', value: 2 },
] as const;

export function StoryTeleprompter({
  scenes,
  chapterTitle,
}: StoryTeleprompterProps) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const animFrameRef = useRef<number>(0);
  const lastTimeRef = useRef<number>(0);

  const [isAutoScroll, setIsAutoScroll] = useState(false);
  const [speedIndex, setSpeedIndex] = useState(1);
  const [showAudioToast, setShowAudioToast] = useState(false);
  const [isAtBottom, setIsAtBottom] = useState(false);

  const speed = SPEED_OPTIONS[speedIndex].value;

  const stopAutoScroll = useCallback(() => {
    setIsAutoScroll(false);
    if (animFrameRef.current) {
      cancelAnimationFrame(animFrameRef.current);
      animFrameRef.current = 0;
    }
  }, []);

  const tick = useCallback(
    (timestamp: number) => {
      if (!scrollRef.current) return;

      if (lastTimeRef.current === 0) {
        lastTimeRef.current = timestamp;
      }

      const delta = timestamp - lastTimeRef.current;
      lastTimeRef.current = timestamp;

      const px = speed * (delta / 16);
      scrollRef.current.scrollTop += px;

      const { scrollTop, scrollHeight, clientHeight } = scrollRef.current;
      if (scrollTop + clientHeight >= scrollHeight - 2) {
        stopAutoScroll();
        return;
      }

      animFrameRef.current = requestAnimationFrame(tick);
    },
    [speed, stopAutoScroll],
  );

  const startAutoScroll = useCallback(() => {
    setIsAutoScroll(true);
    lastTimeRef.current = 0;
    animFrameRef.current = requestAnimationFrame(tick);
  }, [tick]);

  const toggleAutoScroll = useCallback(() => {
    if (isAutoScroll) {
      stopAutoScroll();
    } else {
      startAutoScroll();
    }
  }, [isAutoScroll, stopAutoScroll, startAutoScroll]);

  useEffect(() => {
    if (isAutoScroll) {
      lastTimeRef.current = 0;
      if (animFrameRef.current) {
        cancelAnimationFrame(animFrameRef.current);
      }
      animFrameRef.current = requestAnimationFrame(tick);
    }
  }, [speed, isAutoScroll, tick]);

  useEffect(() => {
    return () => {
      if (animFrameRef.current) {
        cancelAnimationFrame(animFrameRef.current);
      }
    };
  }, []);

  useEffect(() => {
    const el = scrollRef.current;
    if (!el) return;

    let touchStartY = 0;

    const handleWheel = () => {
      if (isAutoScroll) stopAutoScroll();
    };

    const handleTouchStart = (e: TouchEvent) => {
      touchStartY = e.touches[0].clientY;
    };

    const handleTouchMove = (e: TouchEvent) => {
      const delta = Math.abs(e.touches[0].clientY - touchStartY);
      if (delta > 5 && isAutoScroll) stopAutoScroll();
    };

    el.addEventListener('wheel', handleWheel, { passive: true });
    el.addEventListener('touchstart', handleTouchStart, { passive: true });
    el.addEventListener('touchmove', handleTouchMove, { passive: true });

    return () => {
      el.removeEventListener('wheel', handleWheel);
      el.removeEventListener('touchstart', handleTouchStart);
      el.removeEventListener('touchmove', handleTouchMove);
    };
  }, [isAutoScroll, stopAutoScroll]);

  useEffect(() => {
    const el = scrollRef.current;
    if (!el) return;

    const handleScroll = () => {
      const { scrollTop, scrollHeight, clientHeight } = el;
      setIsAtBottom(scrollTop + clientHeight >= scrollHeight - 10);
    };

    el.addEventListener('scroll', handleScroll, { passive: true });
    return () => el.removeEventListener('scroll', handleScroll);
  }, []);

  const handleAudioClick = () => {
    setShowAudioToast(true);
    setTimeout(() => setShowAudioToast(false), 2500);
  };

  const cycleSpeed = () => {
    setSpeedIndex((prev) => (prev + 1) % SPEED_OPTIONS.length);
  };

  if (scenes.length === 0) {
    return (
      <div className="flex-1 flex items-center justify-center text-gray-400">
        <p>This chapter's story is coming soon...</p>
      </div>
    );
  }

  return (
    <div className="flex flex-col flex-1 min-h-0">
      <div className="flex items-center justify-between px-4 py-2 bg-white/60 backdrop-blur-sm border-b border-gray-200/50">
        <div className="flex items-center gap-2">
          <button
            onClick={toggleAutoScroll}
            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
              isAutoScroll
                ? 'bg-teal-500 text-white shadow-md'
                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            }`}
          >
            {isAutoScroll ? (
              <>
                <Pause size={14} />
                <span className="hidden sm:inline">Auto</span>
              </>
            ) : (
              <>
                <Play size={14} />
                <span className="hidden sm:inline">Auto</span>
              </>
            )}
          </button>

          {isAutoScroll && (
            <button
              onClick={cycleSpeed}
              className="flex items-center gap-1 px-2.5 py-1.5 rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 text-sm transition-all"
              title="Change speed"
            >
              <Gauge size={14} />
              <span className="text-xs font-medium">
                {SPEED_OPTIONS[speedIndex].label}
              </span>
            </button>
          )}

          {!isAutoScroll && (
            <span className="flex items-center gap-1 text-xs text-gray-400 ml-1">
              <Hand size={12} />
              <span className="hidden sm:inline">Scroll to read</span>
            </span>
          )}
        </div>

        <div className="relative">
          <button
            onClick={handleAudioClick}
            className="flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 text-sm font-medium transition-all"
          >
            <Volume2 size={14} />
            <span className="hidden sm:inline">Listen</span>
          </button>

          {showAudioToast && (
            <div className="absolute right-0 top-full mt-2 px-3 py-2 bg-gray-800 text-white text-xs rounded-lg shadow-lg whitespace-nowrap z-50 animate-fade-in">
              Coming soon
              <div className="absolute -top-1 right-4 w-2 h-2 bg-gray-800 rotate-45" />
            </div>
          )}
        </div>
      </div>

      <div
        ref={scrollRef}
        className="teleprompter-container flex-1 min-h-0 overflow-y-auto"
      >
        <div className="max-w-2xl mx-auto px-6 py-8">
          <h2 className="text-center text-sm font-medium text-teal-600 mb-8 tracking-wider uppercase">
            {chapterTitle}
          </h2>

          {scenes.map((scene, index) => (
            <div
              key={scene.id}
              className="scene-enter mb-12"
              style={{ animationDelay: `${index * 0.1}s` }}
            >
              {scene.title && (
                <div className="flex items-center gap-3 mb-4">
                  <div className="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent" />
                  <span className="text-xs font-medium text-gray-400 tracking-wide uppercase whitespace-nowrap">
                    {scene.title}
                  </span>
                  <div className="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent" />
                </div>
              )}

              <div className="text-gray-700 text-lg leading-loose whitespace-pre-line">
                {scene.content}
              </div>

              {scene.terms_introduced.length > 0 && (
                <div className="mt-4 flex items-center gap-2 flex-wrap">
                  {scene.terms_introduced.map((termId) => (
                    <span
                      key={termId}
                      className="inline-flex items-center px-2.5 py-0.5 rounded-full bg-teal-50 text-teal-700 text-xs font-medium border border-teal-100"
                    >
                      {termId}
                    </span>
                  ))}
                </div>
              )}
            </div>
          ))}

          <div className="text-center py-8">
            <div className="inline-flex items-center gap-2 text-gray-300">
              <div className="h-px w-12 bg-gray-200" />
              <ChevronsDown size={16} />
              <div className="h-px w-12 bg-gray-200" />
            </div>
          </div>
        </div>
      </div>

      {isAutoScroll && !isAtBottom && (
        <div className="absolute bottom-20 left-1/2 -translate-x-1/2 z-20">
          <button
            onClick={stopAutoScroll}
            className="px-4 py-2 bg-gray-800/80 text-white text-sm rounded-full backdrop-blur-sm shadow-lg hover:bg-gray-800 transition-all"
          >
            Tap to stop
          </button>
        </div>
      )}
    </div>
  );
}
