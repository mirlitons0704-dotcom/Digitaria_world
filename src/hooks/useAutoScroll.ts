import { useState, useRef, useEffect, useCallback, type RefObject, type Ref } from 'react';
import { SPEED_OPTIONS } from '../components/TeleprompterControls';

const MANUAL_SCROLL_STEP = 200;

interface TtsState {
  status: 'idle' | 'loading' | 'playing' | 'paused' | 'error';
  currentSceneIndex: number;
}

interface UseAutoScrollOptions {
  scenes: { id: string | number }[];
  tts: TtsState;
  sceneRefs: RefObject<(HTMLDivElement | null)[]>;
}

interface UseAutoScrollReturn {
  scrollRef: Ref<HTMLDivElement>;
  isAutoScroll: boolean;
  speedIndex: number;
  scrollProgress: number;
  isAtTop: boolean;
  isAtBottom: boolean;
  showScrollNav: boolean;
  toggleAutoScroll: () => void;
  stopAutoScroll: () => void;
  setSpeedIndex: (index: number) => void;
  scrollBy: (amount: number) => void;
  scrollToTop: () => void;
  scrollToBottom: () => void;
}

export function useAutoScroll({
  scenes,
  tts,
  sceneRefs,
}: UseAutoScrollOptions): UseAutoScrollReturn {
  const scrollRef = useRef<HTMLDivElement>(null);
  const animFrameRef = useRef<number>(0);
  const lastTimeRef = useRef<number>(0);
  const subPixelRef = useRef<number>(0);

  const [isAutoScroll, setIsAutoScroll] = useState(false);
  const [speedIndex, setSpeedIndex] = useState(0);
  const [isAtBottom, setIsAtBottom] = useState(false);
  const [isAtTop, setIsAtTop] = useState(true);
  const [scrollProgress, setScrollProgress] = useState(0);
  const [showScrollNav, setShowScrollNav] = useState(false);

  const userScrolledRef = useRef(false);
  const prevSceneIndexRef = useRef(0);

  const speed = SPEED_OPTIONS[speedIndex].value;

  const stopAutoScroll = useCallback(() => {
    setIsAutoScroll(false);
    if (animFrameRef.current) {
      cancelAnimationFrame(animFrameRef.current);
      animFrameRef.current = 0;
    }
  }, []);

  // ---------- TTS scroll sync ----------

  useEffect(() => {
    if (tts.currentSceneIndex !== prevSceneIndexRef.current) {
      userScrolledRef.current = false;
      prevSceneIndexRef.current = tts.currentSceneIndex;
    }

    if ((tts.status !== 'loading' && tts.status !== 'playing') || userScrolledRef.current) return;

    const el = sceneRefs.current?.[tts.currentSceneIndex];
    const container = scrollRef.current;
    if (!el || !container) return;

    if (isAutoScroll) stopAutoScroll();

    const targetTop = el.offsetTop - 20;
    container.scrollTo({ top: targetTop, behavior: 'smooth' });
  }, [tts.currentSceneIndex, tts.status, isAutoScroll, stopAutoScroll, sceneRefs]);

  // ---------- rAF tick ----------

  const tick = useCallback(
    (timestamp: number) => {
      if (!scrollRef.current) return;

      if (lastTimeRef.current === 0) {
        lastTimeRef.current = timestamp;
      }

      const delta = timestamp - lastTimeRef.current;
      lastTimeRef.current = timestamp;

      subPixelRef.current += speed * (delta / 16);
      const whole = Math.floor(subPixelRef.current);
      if (whole >= 1) {
        scrollRef.current.scrollTop += whole;
        subPixelRef.current -= whole;
      }

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
    subPixelRef.current = 0;
    animFrameRef.current = requestAnimationFrame(tick);
  }, [tick]);

  const toggleAutoScroll = useCallback(() => {
    if (isAutoScroll) {
      stopAutoScroll();
    } else {
      startAutoScroll();
    }
  }, [isAutoScroll, stopAutoScroll, startAutoScroll]);

  // Restart animation when speed changes
  useEffect(() => {
    if (isAutoScroll) {
      lastTimeRef.current = 0;
      if (animFrameRef.current) {
        cancelAnimationFrame(animFrameRef.current);
      }
      animFrameRef.current = requestAnimationFrame(tick);
    }
  }, [speed, isAutoScroll, tick]);

  // Cleanup on unmount
  useEffect(() => {
    return () => {
      if (animFrameRef.current) {
        cancelAnimationFrame(animFrameRef.current);
      }
    };
  }, []);

  // ---------- User interaction: stop auto-scroll on manual scroll ----------

  useEffect(() => {
    const el = scrollRef.current;
    if (!el) return;

    let touchStartY = 0;
    let touchMoved = false;

    const handleWheel = () => {
      if (isAutoScroll) stopAutoScroll();
      if (tts.status === 'playing' || tts.status === 'loading') {
        userScrolledRef.current = true;
      }
    };

    const handleTouchStart = (e: TouchEvent) => {
      touchStartY = e.touches[0].clientY;
      touchMoved = false;
    };

    const handleTouchMove = (e: TouchEvent) => {
      const delta = Math.abs(e.touches[0].clientY - touchStartY);
      if (delta > 5) {
        touchMoved = true;
        if (isAutoScroll) stopAutoScroll();
        if (tts.status === 'playing' || tts.status === 'loading') {
          userScrolledRef.current = true;
        }
      }
    };

    const handleClick = (e: MouseEvent) => {
      if (!isAutoScroll) return;
      const target = e.target as HTMLElement;
      if (target.closest('button, a, select, input, textarea')) return;
      stopAutoScroll();
    };

    const handleTouchEnd = () => {
      if (!isAutoScroll || touchMoved) return;
      stopAutoScroll();
    };

    el.addEventListener('wheel', handleWheel, { passive: true });
    el.addEventListener('touchstart', handleTouchStart, { passive: true });
    el.addEventListener('touchmove', handleTouchMove, { passive: true });
    el.addEventListener('touchend', handleTouchEnd, { passive: true });
    el.addEventListener('click', handleClick);

    return () => {
      el.removeEventListener('wheel', handleWheel);
      el.removeEventListener('touchstart', handleTouchStart);
      el.removeEventListener('touchmove', handleTouchMove);
      el.removeEventListener('touchend', handleTouchEnd);
      el.removeEventListener('click', handleClick);
    };
  }, [isAutoScroll, stopAutoScroll, tts.status]);

  // ---------- Scroll position tracking ----------

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

  // ---------- Scroll helpers ----------

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

  // ---------- Keyboard shortcuts ----------

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

  return {
    scrollRef,
    isAutoScroll,
    speedIndex,
    scrollProgress,
    isAtTop,
    isAtBottom,
    showScrollNav,
    toggleAutoScroll,
    stopAutoScroll,
    setSpeedIndex,
    scrollBy,
    scrollToTop,
    scrollToBottom,
  };
}
