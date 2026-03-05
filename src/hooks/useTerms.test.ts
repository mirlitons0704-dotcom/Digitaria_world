import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, waitFor, act } from '@testing-library/react';
import { useTermsByChapter, useTerm, useSearchTerms, useQuizTerms } from './useTerms';
import * as api from '../lib/api';
import { createMockTerm, createMockTerms, createQueryWrapper } from '../test/test-utils';

// Mock the Supabase client to prevent createClient error in test env
vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

// Mock the API module
vi.mock('../lib/api');

describe('useTermsByChapter', () => {
  const mockTerms = createMockTerms(5, 1);

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns empty array when chapterId is null', async () => {
    const { result } = renderHook(() => useTermsByChapter(null), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.terms).toEqual([]);
    expect(api.getTermsByChapter).not.toHaveBeenCalled();
  });

  it('fetches terms when chapterId is provided', async () => {
    vi.mocked(api.getTermsByChapter).mockResolvedValue(mockTerms);

    const { result } = renderHook(() => useTermsByChapter(1), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.terms).toEqual(mockTerms);
    expect(api.getTermsByChapter).toHaveBeenCalledWith(1);
  });

  it('refetches when chapterId changes', async () => {
    const mockTermsChapter2 = createMockTerms(3, 2);
    vi.mocked(api.getTermsByChapter)
      .mockResolvedValueOnce(mockTerms)
      .mockResolvedValueOnce(mockTermsChapter2);

    const wrapper = createQueryWrapper();
    const { result, rerender } = renderHook(({ id }) => useTermsByChapter(id), {
      initialProps: { id: 1 as number | null },
      wrapper,
    });

    await waitFor(() => {
      expect(result.current.terms).toEqual(mockTerms);
    });

    rerender({ id: 2 });

    await waitFor(() => {
      expect(result.current.terms).toEqual(mockTermsChapter2);
    });
  });

  it('handles errors correctly', async () => {
    const mockError = new Error('Failed to fetch terms');
    vi.mocked(api.getTermsByChapter).mockRejectedValue(mockError);

    const { result } = renderHook(() => useTermsByChapter(1), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.error).toEqual(mockError);
  });

  it('retry recovers from error', async () => {
    const mockError = new Error('Network error');
    vi.mocked(api.getTermsByChapter)
      .mockRejectedValueOnce(mockError)
      .mockResolvedValueOnce(mockTerms);

    const wrapper = createQueryWrapper();
    const { result } = renderHook(() => useTermsByChapter(1), { wrapper });

    await waitFor(() => {
      expect(result.current.error).toEqual(mockError);
    });

    await act(async () => {
      result.current.retry();
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.error).toBe(null);
    expect(result.current.terms).toEqual(mockTerms);
  });
});

describe('useTerm', () => {
  const mockTerm = createMockTerm();

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns null when id is null', async () => {
    const { result } = renderHook(() => useTerm(null), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.term).toBe(null);
    expect(api.getTerm).not.toHaveBeenCalled();
  });

  it('fetches term when id is provided', async () => {
    vi.mocked(api.getTerm).mockResolvedValue(mockTerm);

    const { result } = renderHook(() => useTerm('binary'), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.term).toEqual(mockTerm);
    expect(api.getTerm).toHaveBeenCalledWith('binary');
  });
});

describe('useSearchTerms', () => {
  const mockSearchResults = createMockTerms(3);

  beforeEach(() => {
    vi.resetAllMocks();
    vi.useFakeTimers();
  });

  afterEach(() => {
    vi.useRealTimers();
  });

  it('returns empty results for empty query', async () => {
    const { result } = renderHook(() => useSearchTerms(''), { wrapper: createQueryWrapper() });

    expect(result.current.results).toEqual([]);
    expect(result.current.loading).toBe(false);
    expect(api.searchTerms).not.toHaveBeenCalled();
  });

  it('returns empty results for whitespace-only query', async () => {
    const { result } = renderHook(() => useSearchTerms('   '), { wrapper: createQueryWrapper() });

    expect(result.current.results).toEqual([]);
    expect(api.searchTerms).not.toHaveBeenCalled();
  });

  it('debounces search calls', async () => {
    vi.mocked(api.searchTerms).mockResolvedValue(mockSearchResults);

    const wrapper = createQueryWrapper();
    const { rerender } = renderHook(({ query }) => useSearchTerms(query), {
      initialProps: { query: 'b' },
      wrapper,
    });

    // Query changes rapidly
    rerender({ query: 'bi' });
    rerender({ query: 'bin' });
    rerender({ query: 'bina' });

    // API should not have been called yet (within debounce period)
    expect(api.searchTerms).not.toHaveBeenCalled();

    // Advance timers past debounce period
    await act(async () => {
      vi.advanceTimersByTime(300);
    });

    // Now API should be called with final query
    expect(api.searchTerms).toHaveBeenCalledWith('bina');
    expect(api.searchTerms).toHaveBeenCalledTimes(1);
  });

  it('returns search results after debounce', async () => {
    vi.mocked(api.searchTerms).mockResolvedValue(mockSearchResults);

    const { result } = renderHook(() => useSearchTerms('binary'), {
      wrapper: createQueryWrapper(),
    });

    // Initially loading is false because debounced query is empty
    expect(result.current.loading).toBe(false);

    // Advance timers past debounce period
    await act(async () => {
      vi.advanceTimersByTime(350);
    });

    // Flush TanStack Query microtasks
    await act(async () => {
      await vi.runAllTimersAsync();
      await Promise.resolve();
      await Promise.resolve();
    });

    // Check results are set
    expect(api.searchTerms).toHaveBeenCalledWith('binary');
    expect(result.current.results).toEqual(mockSearchResults);
    expect(result.current.loading).toBe(false);
  });
});

describe('useQuizTerms', () => {
  const mockQuizTerms = createMockTerms(10);

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('fetches random terms on mount', async () => {
    vi.mocked(api.getRandomTermsForQuiz).mockResolvedValue(mockQuizTerms);

    const { result } = renderHook(() => useQuizTerms(null, 10), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.terms).toEqual(mockQuizTerms);
    expect(api.getRandomTermsForQuiz).toHaveBeenCalledWith(null, 10);
  });

  it('fetches terms for specific chapter', async () => {
    vi.mocked(api.getRandomTermsForQuiz).mockResolvedValue(mockQuizTerms);

    const { result } = renderHook(() => useQuizTerms(1, 10), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(api.getRandomTermsForQuiz).toHaveBeenCalledWith(1, 10);
  });

  it('refresh function fetches new terms', async () => {
    vi.mocked(api.getRandomTermsForQuiz).mockResolvedValue(mockQuizTerms);

    const wrapper = createQueryWrapper();
    const { result } = renderHook(() => useQuizTerms(null, 10), { wrapper });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(api.getRandomTermsForQuiz).toHaveBeenCalledTimes(1);

    // Call refresh
    await act(async () => {
      result.current.refresh();
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(api.getRandomTermsForQuiz).toHaveBeenCalledTimes(2);
  });

  it('uses default count of 10', async () => {
    vi.mocked(api.getRandomTermsForQuiz).mockResolvedValue(mockQuizTerms);

    renderHook(() => useQuizTerms(null), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(api.getRandomTermsForQuiz).toHaveBeenCalledWith(null, 10);
    });
  });
});
