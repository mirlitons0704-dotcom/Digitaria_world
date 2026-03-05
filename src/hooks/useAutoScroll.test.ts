import { describe, it, expect, vi } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useAutoScroll } from './useAutoScroll';
import { createRef } from 'react';

describe('useAutoScroll', () => {
  const defaultOptions = {
    scenes: [{ id: '1' }, { id: '2' }],
    tts: { status: 'idle' as const, currentSceneIndex: 0 },
    sceneRefs: createRef<(HTMLDivElement | null)[]>(),
  };

  it('returns initial state', () => {
    const { result } = renderHook(() => useAutoScroll(defaultOptions));

    expect(result.current.isAutoScroll).toBe(false);
    expect(result.current.speedIndex).toBe(0);
    expect(result.current.isAtTop).toBe(true);
    expect(result.current.isAtBottom).toBe(false);
    expect(result.current.scrollProgress).toBe(0);
    expect(result.current.showScrollNav).toBe(false);
  });

  it('provides scroll control functions', () => {
    const { result } = renderHook(() => useAutoScroll(defaultOptions));

    expect(typeof result.current.toggleAutoScroll).toBe('function');
    expect(typeof result.current.stopAutoScroll).toBe('function');
    expect(typeof result.current.setSpeedIndex).toBe('function');
    expect(typeof result.current.scrollBy).toBe('function');
    expect(typeof result.current.scrollToTop).toBe('function');
    expect(typeof result.current.scrollToBottom).toBe('function');
  });

  it('setSpeedIndex updates the speed', () => {
    const { result } = renderHook(() => useAutoScroll(defaultOptions));

    act(() => {
      result.current.setSpeedIndex(3);
    });

    expect(result.current.speedIndex).toBe(3);
  });

  it('toggleAutoScroll toggles the state', () => {
    // Mock requestAnimationFrame for auto-scroll
    const rafSpy = vi.spyOn(window, 'requestAnimationFrame').mockReturnValue(1);

    const { result } = renderHook(() => useAutoScroll(defaultOptions));

    act(() => {
      result.current.toggleAutoScroll();
    });

    expect(result.current.isAutoScroll).toBe(true);

    act(() => {
      result.current.toggleAutoScroll();
    });

    expect(result.current.isAutoScroll).toBe(false);

    rafSpy.mockRestore();
  });

  it('stopAutoScroll sets isAutoScroll to false', () => {
    const rafSpy = vi.spyOn(window, 'requestAnimationFrame').mockReturnValue(1);
    const cafSpy = vi.spyOn(window, 'cancelAnimationFrame').mockImplementation(() => {});

    const { result } = renderHook(() => useAutoScroll(defaultOptions));

    act(() => {
      result.current.toggleAutoScroll(); // start
    });

    expect(result.current.isAutoScroll).toBe(true);

    act(() => {
      result.current.stopAutoScroll();
    });

    expect(result.current.isAutoScroll).toBe(false);

    rafSpy.mockRestore();
    cafSpy.mockRestore();
  });
});
