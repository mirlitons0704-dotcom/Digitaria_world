import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, waitFor, act } from '@testing-library/react';
import { useChapters, useChapter, useChapterWithGuide } from './useChapters';
import * as api from '../lib/api';
import { createMockChapter, createMockCharacter, createQueryWrapper } from '../test/test-utils';

// Mock the Supabase client to prevent createClient error in test env
vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

// Mock the API module
vi.mock('../lib/api');

describe('useChapters', () => {
  const mockChapters = [
    createMockChapter({ id: 1 }),
    createMockChapter({ id: 2 }),
    createMockChapter({ id: 3 }),
  ];

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns loading state initially', () => {
    vi.mocked(api.getChapters).mockImplementation(() => new Promise(() => {}));

    const { result } = renderHook(() => useChapters(), { wrapper: createQueryWrapper() });

    expect(result.current.loading).toBe(true);
    expect(result.current.chapters).toEqual([]);
    expect(result.current.error).toBe(null);
  });

  it('returns chapters after successful fetch', async () => {
    vi.mocked(api.getChapters).mockResolvedValue(mockChapters);

    const { result } = renderHook(() => useChapters(), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.chapters).toEqual(mockChapters);
    expect(result.current.error).toBe(null);
  });

  it('returns error after failed fetch', async () => {
    const mockError = new Error('Failed to fetch chapters');
    vi.mocked(api.getChapters).mockRejectedValue(mockError);

    const { result } = renderHook(() => useChapters(), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.chapters).toEqual([]);
    expect(result.current.error).toEqual(mockError);
  });

  it('retry recovers from error', async () => {
    const mockError = new Error('Network error');
    vi.mocked(api.getChapters).mockRejectedValueOnce(mockError).mockResolvedValueOnce(mockChapters);

    const wrapper = createQueryWrapper();
    const { result } = renderHook(() => useChapters(), { wrapper });

    await waitFor(() => {
      expect(result.current.error).toEqual(mockError);
    });

    // Retry
    await act(async () => {
      result.current.retry();
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.error).toBe(null);
    expect(result.current.chapters).toEqual(mockChapters);
  });
});

describe('useChapter', () => {
  const mockChapter = createMockChapter({ id: 1 });

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns null chapter when id is null', async () => {
    const { result } = renderHook(() => useChapter(null), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.chapter).toBe(null);
    expect(api.getChapter).not.toHaveBeenCalled();
  });

  it('fetches chapter when id is provided', async () => {
    vi.mocked(api.getChapter).mockResolvedValue(mockChapter);

    const { result } = renderHook(() => useChapter(1), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.chapter).toEqual(mockChapter);
    expect(api.getChapter).toHaveBeenCalledWith(1);
  });

  it('refetches when id changes', async () => {
    const mockChapter2 = createMockChapter({ id: 2 });
    vi.mocked(api.getChapter)
      .mockResolvedValueOnce(mockChapter)
      .mockResolvedValueOnce(mockChapter2);

    const wrapper = createQueryWrapper();
    const { result, rerender } = renderHook(({ id }) => useChapter(id), {
      initialProps: { id: 1 as number | null },
      wrapper,
    });

    await waitFor(() => {
      expect(result.current.chapter).toEqual(mockChapter);
    });

    rerender({ id: 2 });

    await waitFor(() => {
      expect(result.current.chapter).toEqual(mockChapter2);
    });

    expect(api.getChapter).toHaveBeenCalledTimes(2);
  });
});

describe('useChapterWithGuide', () => {
  const mockGuide = createMockCharacter();
  const mockChapterWithGuide = {
    ...createMockChapter({ id: 1 }),
    guide: mockGuide,
  };

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns null when id is null', async () => {
    const { result } = renderHook(() => useChapterWithGuide(null), {
      wrapper: createQueryWrapper(),
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.chapter).toBe(null);
    expect(api.getChapterWithGuide).not.toHaveBeenCalled();
  });

  it('fetches chapter with guide when id is provided', async () => {
    vi.mocked(api.getChapterWithGuide).mockResolvedValue(mockChapterWithGuide);

    const { result } = renderHook(() => useChapterWithGuide(1), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.chapter).toEqual(mockChapterWithGuide);
    expect(result.current.chapter?.guide).toEqual(mockGuide);
    expect(api.getChapterWithGuide).toHaveBeenCalledWith(1);
  });
});
