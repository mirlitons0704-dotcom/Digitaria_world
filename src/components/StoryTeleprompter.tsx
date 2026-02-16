import { useState, useRef, useEffect, useCallback, useMemo } from 'react';
import {
  Play,
  Pause,
  Volume2,
  VolumeX,
  ChevronDownIcon,
  Hand,
  ChevronsDown,
  ChevronUp,
  ChevronDown,
  ChevronsUp,
  ToggleLeft,
  ToggleRight,
  Loader2,
  Square,
} from 'lucide-react';
import type { StoryScene, Term } from '../lib/database.types';
import { InlineTermCard } from './InlineTermCard';
import { useAuth } from '../contexts/AuthContext';
import { saveTermProgress, getUserCollectedTerms } from '../lib/api';
import { useTts } from '../hooks/useTts';

interface StoryTeleprompterProps {
  scenes: StoryScene[];
  chapterTitle: string;
  terms?: Term[];
}

const SPEED_OPTIONS = [
  { label: 'Super Slow', value: 0.25 },
  { label: 'Slow', value: 0.5 },
  { label: 'Normal', value: 1 },
  { label: 'Fast', value: 2 },
  { label: 'Turbo', value: 3.5 },
] as const;

const MANUAL_SCROLL_STEP = 200;

const MEDIA_MARKER_RE = /\{\{(image|video):([^}]+)\}\}/;

type MediaSegment = { type: 'image' | 'video'; src: string };

function splitContentByMedia(content: string) {
  const segments: (string | MediaSegment)[] = [];
  let remaining = content;
  while (remaining) {
    const match = MEDIA_MARKER_RE.exec(remaining);
    if (!match) {
      segments.push(remaining);
      break;
    }
    if (match.index > 0) {
      segments.push(remaining.slice(0, match.index));
    }
    segments.push({ type: match[1] as 'image' | 'video', src: match[2] });
    remaining = remaining.slice(match.index + match[0].length);
  }
  return segments;
}

export function StoryTeleprompter({ scenes, chapterTitle, terms = [] }: StoryTeleprompterProps) {
  const { user } = useAuth();
  const scrollRef = useRef<HTMLDivElement>(null);
  const animFrameRef = useRef<number>(0);
  const lastTimeRef = useRef<number>(0);

  const [isAutoScroll, setIsAutoScroll] = useState(false);
  const [speedIndex, setSpeedIndex] = useState(1);
  const [isAtBottom, setIsAtBottom] = useState(false);
  const [isAtTop, setIsAtTop] = useState(true);
  const [scrollProgress, setScrollProgress] = useState(0);
  const [showScrollNav, setShowScrollNav] = useState(false);
  const [expandedTermId, setExpandedTermId] = useState<string | null>(null);
  const [collectedTermIds, setCollectedTermIds] = useState<Set<string>>(new Set());
  const [savingTermId, setSavingTermId] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);

  const tts = useTts(scenes);

  // Auto-dismiss save error after 3 seconds
  useEffect(() => {
    if (!saveError) return;
    const timer = setTimeout(() => setSaveError(null), 3000);
    return () => clearTimeout(timer);
  }, [saveError]);

  useEffect(() => {
    if (!user) return;
    getUserCollectedTerms(user.id)
      .then((progress) => {
        setCollectedTermIds(new Set(progress.map((p) => p.term_id)));
      })
      .catch(() => {
        // Non-critical: collected status will just not show
      });
  }, [user]);

  const handleGotIt = useCallback(
    async (termId: string) => {
      if (!user) return;
      setSavingTermId(termId);
      setSaveError(null);
      try {
        await saveTermProgress(user.id, termId, 3, 'butterfly');
        setCollectedTermIds((prev) => new Set([...prev, termId]));
      } catch {
        setSaveError('Failed to save progress. Please try again.');
      } finally {
        setSavingTermId(null);
      }
    },
    [user]
  );

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
    [speed, stopAutoScroll]
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
    if (tts.status === 'playing') {
      tts.pause();
    } else if (tts.status === 'paused') {
      tts.play();
    } else if (tts.status === 'loading') {
      tts.stop();
    } else {
      tts.play();
    }
  };

  const scrollBy = useCallback(
    (amount: number) => {
      if (!scrollRef.current) return;
      if (isAutoScroll) stopAutoScroll();
      scrollRef.current.scrollBy({ top: amount, behavior: 'smooth' });
    },
    [isAutoScroll, stopAutoScroll]
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
        e.target instanceof HTMLTextAreaElement ||
        e.target instanceof HTMLSelectElement
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
      {saveError && (
        <div
          role="alert"
          className="absolute top-4 left-1/2 -translate-x-1/2 z-50 px-4 py-2 bg-red-600 text-white text-sm rounded-lg shadow-lg animate-fade-in"
        >
          {saveError}
        </div>
      )}
      <div className="relative">
        <div className="flex items-center justify-between px-4 py-2 bg-white/60 backdrop-blur-sm border-b border-gray-200/50">
          <div className="flex items-center gap-2">
            <button
              onClick={toggleAutoScroll}
              aria-label={isAutoScroll ? 'オートスクロールを停止' : 'オートスクロールを開始'}
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
              <div className="relative flex items-center">
                <select
                  value={speedIndex}
                  onChange={(e) => {
                    setSpeedIndex(Number(e.target.value));
                    e.target.blur();
                  }}
                  className="appearance-none pl-2.5 pr-6 py-1.5 rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 text-xs font-medium transition-all cursor-pointer focus:outline-none focus:ring-2 focus:ring-teal-500/30"
                >
                  {SPEED_OPTIONS.map((opt, i) => (
                    <option key={i} value={i}>
                      {opt.label}
                    </option>
                  ))}
                </select>
                <ChevronDownIcon
                  size={12}
                  className="absolute right-2 pointer-events-none text-gray-500"
                />
              </div>
            )}

            {!isAutoScroll && (
              <span className="flex items-center gap-1 text-xs text-gray-500 ml-1">
                <Hand size={12} />
                <span className="hidden sm:inline">Scroll to read</span>
              </span>
            )}
          </div>

          <div className="flex items-center gap-2">
            <span className="text-xs text-gray-500 tabular-nums hidden sm:inline">
              {Math.round(scrollProgress * 100)}%
            </span>

            <div className="flex items-center gap-1.5">
              {(tts.status === 'playing' ||
                tts.status === 'paused' ||
                tts.status === 'loading') && (
                <button
                  onClick={tts.stop}
                  className="flex items-center gap-1 px-2 py-1.5 rounded-full bg-gray-100 text-gray-500 hover:bg-red-50 hover:text-red-500 text-sm transition-all"
                  title="Stop"
                  aria-label="音声を停止"
                >
                  <Square size={12} />
                </button>
              )}

              <div className="relative">
                <button
                  onClick={handleAudioClick}
                  disabled={tts.status === 'loading'}
                  aria-label={
                    tts.status === 'playing'
                      ? '音声を一時停止'
                      : tts.status === 'paused'
                        ? '音声を再開'
                        : '音声を再生'
                  }
                  className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
                    tts.status === 'playing'
                      ? 'bg-teal-500 text-white shadow-md'
                      : tts.status === 'loading'
                        ? 'bg-amber-100 text-amber-600 cursor-wait'
                        : tts.status === 'error'
                          ? 'bg-red-50 text-red-500 hover:bg-red-100'
                          : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                  }`}
                >
                  {tts.status === 'loading' ? (
                    <Loader2 size={14} className="animate-spin" />
                  ) : tts.status === 'playing' ? (
                    <Pause size={14} />
                  ) : tts.status === 'error' ? (
                    <VolumeX size={14} />
                  ) : (
                    <Volume2 size={14} />
                  )}
                  <span className="hidden sm:inline">
                    {tts.status === 'loading'
                      ? `Loading ${tts.currentSceneIndex + 1}/${scenes.length}`
                      : tts.status === 'playing'
                        ? `${tts.currentSceneIndex + 1}/${scenes.length}`
                        : tts.status === 'paused'
                          ? 'Resume'
                          : tts.status === 'error'
                            ? 'Retry'
                            : 'Listen'}
                  </span>
                </button>

                {tts.status === 'error' && tts.errorMessage && (
                  <div className="absolute right-0 top-full mt-2 px-3 py-2 bg-red-800 text-white text-xs rounded-lg shadow-lg whitespace-nowrap z-50 animate-fade-in max-w-[200px] truncate">
                    {tts.errorMessage}
                    <div className="absolute -top-1 right-4 w-2 h-2 bg-red-800 rotate-45" />
                  </div>
                )}
              </div>
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
        <div ref={scrollRef} className="teleprompter-container h-full overflow-y-auto">
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
                      alt={scene.title || 'シーン画像'}
                      className="w-[336px] h-[336px] object-contain drop-shadow-lg"
                      loading="lazy"
                    />
                  </div>
                )}

                <div className="text-gray-700 text-lg leading-loose whitespace-pre-line">
                  {splitContentByMedia(scene.content).map((segment, i) =>
                    typeof segment === 'string' ? (
                      segment
                    ) : (
                      <span key={i} className="flex justify-center my-8">
                        <img
                          src={segment.src}
                          alt=""
                          className={`object-contain drop-shadow-lg ${
                            segment.src.includes('memorygarden') ? 'w-[60%]' : 'w-[42%]'
                          }`}
                          loading="lazy"
                        />
                      </span>
                    )
                  )}
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

        {saveError && (
          <div
            role="alert"
            className="absolute top-3 left-1/2 -translate-x-1/2 z-30 px-4 py-2 bg-red-600 text-white text-sm rounded-lg shadow-lg"
          >
            {saveError}
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
