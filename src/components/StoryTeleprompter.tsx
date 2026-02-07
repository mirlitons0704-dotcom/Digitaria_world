import { useState, useRef, useEffect, useCallback, useMemo } from 'react';
import {
  Play,
  Pause,
  Volume2,
  Gauge,
  Hand,
  ChevronsDown,
  ChevronUp,
  ChevronDown,
  ChevronsUp,
  ToggleLeft,
  ToggleRight,
} from 'lucide-react';
import type { StoryScene, Term } from '../lib/database.types';
import { InlineTermCard } from './InlineTermCard';
import { useAuth } from '../contexts/AuthContext';
import { saveTermProgress, getUserCollectedTerms } from '../lib/api';

interface StoryTeleprompterProps {
  scenes: StoryScene[];
  chapterTitle: string;
  terms?: Term[];
}

const SPEED_OPTIONS = [
  { label: 'Slow', value: 0.5 },
  { label: 'Normal', value: 1 },
  { label: 'Fast', value: 2 },
  { label: 'Turbo', value: 3.5 },
] as const;

const MANUAL_SCROLL_STEP = 200;

export function StoryTeleprompter({
  scenes,
  chapterTitle,
  terms = [],
}: StoryTeleprompterProps) {
  const { user } = useAuth();
  const scrollRef = useRef<HTMLDivElement>(null);
  const animFrameRef = useRef<number>(0);
  const lastTimeRef = useRef<number>(0);

  const [isAutoScroll, setIsAutoScroll] = useState(false);
  const [speedIndex, setSpeedIndex] = useState(1);
  const [showAudioToast, setShowAudioToast] = useState(false);
  const [isAtBottom, setIsAtBottom] = useState(false);
  const [isAtTop, setIsAtTop] = useState(true);
  const [scrollProgress, setScrollProgress] = useState(0);
  const [showScrollNav, setShowScrollNav] = useState(false);
  const [expandedTermId, setExpandedTermId] = useState<string | null>(null);
  const [collectedTermIds, setCollectedTermIds] = useState<Set<string>>(new Set());
  const [savingTermId, setSavingTermId] = useState<string | null>(null);

  useEffect(() => {
    if (!user) return;
    getUserCollectedTerms(user.id).then((progress) => {
      setCollectedTermIds(new Set(progress.map((p) => p.term_id)));
    }).catch(() => {});
  }, [user]);

  const handleGotIt = useCallback(async (termId: string) => {
    if (!user) return;
    setSavingTermId(termId);
    try {
      await saveTermProgress(user.id, termId, 3, 'butterfly');
      setCollectedTermIds((prev) => new Set([...prev, termId]));
    } catch {
      // silent fail
    } finally {
      setSavingTermId(null);
    }
  }, [user]);

  const termMap = useMemo(() => {
    const map = new Map<string, Term>();
    terms.forEach((t) => map.set(t.id, t));
    return map;
  }, [terms]);

  const toggleTerm = useCallback((termId: string) => {
    setExpandedTermId((prev) => (prev === termId ? null : termId));
  }, []);

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
      const maxScroll = scrollHeight - clientHeight;
      setIsAtBottom(scrollTop + clientHeight >= scrollHeight - 10);
      setIsAtTop(scrollTop <= 10);
      setScrollProgress(maxScroll > 0 ? scrollTop / maxScroll : 0);
      setShowScrollNav(maxScroll > 100);
    };

    handleScroll();
    el.addEventListener('scroll', handleScroll, { passive: true });
    return () => el.removeEventListener('scroll', handleScroll);
  }, [scenes]);

  const handleAudioClick = () => {
    setShowAudioToast(true);
    setTimeout(() => setShowAudioToast(false), 2500);
  };

  const cycleSpeed = () => {
    setSpeedIndex((prev) => (prev + 1) % SPEED_OPTIONS.length);
  };

  const scrollBy = useCallback(
    (amount: number) => {
      if (!scrollRef.current) return;
      if (isAutoScroll) stopAutoScroll();
      scrollRef.current.scrollBy({ top: amount, behavior: 'smooth' });
    },
    [isAutoScroll, stopAutoScroll],
  );

  const scrollToTop = useCallback(() => {
    if (!scrollRef.current) return;
    if (isAutoScroll) stopAutoScroll();
    scrollRef.current.scrollTo({ top: 0, behavior: 'smooth' });
  }, [isAutoScroll, stopAutoScroll]);

  const scrollToBottom = useCallback(() => {
    if (!scrollRef.current) return;
    if (isAutoScroll) stopAutoScroll();
    scrollRef.current.scrollTo({
      top: scrollRef.current.scrollHeight,
      behavior: 'smooth',
    });
  }, [isAutoScroll, stopAutoScroll]);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (
        e.target instanceof HTMLInputElement ||
        e.target instanceof HTMLTextAreaElement
      )
        return;

      switch (e.key) {
        case ' ':
          e.preventDefault();
          toggleAutoScroll();
          break;
        case 'ArrowDown':
          e.preventDefault();
          scrollBy(MANUAL_SCROLL_STEP);
          break;
        case 'ArrowUp':
          e.preventDefault();
          scrollBy(-MANUAL_SCROLL_STEP);
          break;
        case 'Home':
          e.preventDefault();
          scrollToTop();
          break;
        case 'End':
          e.preventDefault();
          scrollToBottom();
          break;
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [toggleAutoScroll, scrollBy, scrollToTop, scrollToBottom]);

  if (scenes.length === 0) {
    return (
      <div className="flex-1 flex items-center justify-center text-gray-400">
        <p>This chapter's story is coming soon...</p>
      </div>
    );
  }

  return (
    <div className="flex flex-col flex-1 min-h-0">
      <div className="relative">
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

          <div className="flex items-center gap-2">
            <span className="text-xs text-gray-400 tabular-nums hidden sm:inline">
              {Math.round(scrollProgress * 100)}%
            </span>

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
        </div>

        <div className="h-[2px] bg-gray-100">
          <div
            className="h-full bg-gradient-to-r from-teal-400 to-teal-600 transition-all duration-150 ease-out"
            style={{ width: `${scrollProgress * 100}%` }}
          />
        </div>
      </div>

      <div className="relative flex-1 min-h-0">
        <div
          ref={scrollRef}
          className="teleprompter-container h-full overflow-y-auto"
        >
          <div className="max-w-2xl mx-auto px-6 py-8">
            <h2 className="text-center text-xl font-semibold text-teal-600 mb-10 tracking-wide">
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
                    <span className="text-sm font-semibold text-gray-500 tracking-wide whitespace-nowrap">
                      {scene.title}
                    </span>
                    <div className="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent" />
                  </div>
                )}

                {scene.image_url && (
                  <div className="scene-image-enter flex justify-center my-6">
                    <img
                      src={scene.image_url}
                      alt=""
                      className="w-56 h-56 object-contain drop-shadow-lg"
                      loading="lazy"
                    />
                  </div>
                )}

                <div className="text-gray-700 text-lg leading-loose whitespace-pre-line">
                  {scene.content}
                </div>

                {scene.terms_introduced.length > 0 && (
                  <div className="mt-4">
                    <div className="flex items-center gap-2 flex-wrap">
                      {scene.terms_introduced.map((termId) => {
                        const term = termMap.get(termId);
                        const isExpanded = expandedTermId === termId;
                        return (
                          <button
                            key={termId}
                            onClick={() => toggleTerm(termId)}
                            className={`term-toggle-pill inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold transition-all duration-300 ${
                              isExpanded
                                ? 'term-toggle-pill-active text-white shadow-md'
                                : 'term-toggle-pill-inactive text-emerald-700 hover:shadow-sm'
                            }`}
                          >
                            {isExpanded ? <ToggleRight size={13} /> : <ToggleLeft size={13} />}
                            {term ? term.term : termId}
                          </button>
                        );
                      })}
                    </div>
                    {scene.terms_introduced.map((termId) => {
                      const term = termMap.get(termId);
                      if (!term || expandedTermId !== termId) return null;
                      return (
                        <InlineTermCard
                          key={`card-${termId}`}
                          term={term}
                          isCollected={collectedTermIds.has(termId)}
                          saving={savingTermId === termId}
                          onClose={() => setExpandedTermId(null)}
                          onGotIt={() => handleGotIt(termId)}
                        />
                      );
                    })}
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

        {showScrollNav && !isAutoScroll && (
          <div className="absolute right-3 top-1/2 -translate-y-1/2 flex flex-col gap-1.5 z-20">
            <button
              onClick={scrollToTop}
              disabled={isAtTop}
              className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
                isAtTop
                  ? 'bg-white/40 text-gray-300 cursor-default'
                  : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
              }`}
              title="Scroll to top"
            >
              <ChevronsUp size={16} />
            </button>
            <button
              onClick={() => scrollBy(-MANUAL_SCROLL_STEP)}
              disabled={isAtTop}
              className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
                isAtTop
                  ? 'bg-white/40 text-gray-300 cursor-default'
                  : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
              }`}
              title="Scroll up"
            >
              <ChevronUp size={16} />
            </button>
            <button
              onClick={() => scrollBy(MANUAL_SCROLL_STEP)}
              disabled={isAtBottom}
              className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
                isAtBottom
                  ? 'bg-white/40 text-gray-300 cursor-default'
                  : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
              }`}
              title="Scroll down"
            >
              <ChevronDown size={16} />
            </button>
            <button
              onClick={scrollToBottom}
              disabled={isAtBottom}
              className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
                isAtBottom
                  ? 'bg-white/40 text-gray-300 cursor-default'
                  : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
              }`}
              title="Scroll to bottom"
            >
              <ChevronsDown size={16} />
            </button>
          </div>
        )}

        {isAutoScroll && !isAtBottom && (
          <div className="absolute bottom-6 left-1/2 -translate-x-1/2 z-20">
            <button
              onClick={stopAutoScroll}
              className="px-4 py-2 bg-gray-800/80 text-white text-sm rounded-full backdrop-blur-sm shadow-lg hover:bg-gray-800 transition-all"
            >
              Tap to stop
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
