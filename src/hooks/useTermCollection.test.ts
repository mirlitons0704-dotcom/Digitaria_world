import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, waitFor, act } from '@testing-library/react';
import { useTermCollection } from './useTermCollection';
import * as api from '../lib/api';

vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

vi.mock('../lib/api');

describe('useTermCollection', () => {
  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns empty set when userId is undefined', () => {
    const { result } = renderHook(() => useTermCollection(undefined));

    expect(result.current.collectedTermIds.size).toBe(0);
    expect(result.current.savingTermId).toBe(null);
    expect(result.current.saveError).toBe(null);
    expect(api.getUserCollectedTerms).not.toHaveBeenCalled();
  });

  it('fetches collected terms on mount', async () => {
    vi.mocked(api.getUserCollectedTerms).mockResolvedValue([
      { term_id: 'binary', created_at: '' },
      { term_id: 'bit', created_at: '' },
    ]);

    const { result } = renderHook(() => useTermCollection('u1'));

    await waitFor(() => {
      expect(result.current.collectedTermIds.size).toBe(2);
    });

    expect(result.current.collectedTermIds.has('binary')).toBe(true);
    expect(result.current.collectedTermIds.has('bit')).toBe(true);
  });

  it('handleGotIt saves term progress', async () => {
    vi.mocked(api.getUserCollectedTerms).mockResolvedValue([]);
    vi.mocked(api.saveTermProgress).mockResolvedValue();

    const { result } = renderHook(() => useTermCollection('u1'));

    await waitFor(() => {
      expect(api.getUserCollectedTerms).toHaveBeenCalled();
    });

    await act(async () => {
      await result.current.handleGotIt('binary');
    });

    expect(api.saveTermProgress).toHaveBeenCalledWith('u1', 'binary', 3, 'butterfly');
    expect(result.current.collectedTermIds.has('binary')).toBe(true);
    expect(result.current.savingTermId).toBe(null);
  });

  it('handleGotIt sets error on failure', async () => {
    vi.mocked(api.getUserCollectedTerms).mockResolvedValue([]);
    vi.mocked(api.saveTermProgress).mockRejectedValue(new Error('Network error'));

    const { result } = renderHook(() => useTermCollection('u1'));

    await waitFor(() => {
      expect(api.getUserCollectedTerms).toHaveBeenCalled();
    });

    await act(async () => {
      await result.current.handleGotIt('binary');
    });

    expect(result.current.saveError).toBe('Failed to save progress. Please try again.');
    expect(result.current.collectedTermIds.has('binary')).toBe(false);
  });

  it('does nothing when handleGotIt called without userId', async () => {
    const { result } = renderHook(() => useTermCollection(undefined));

    await act(async () => {
      await result.current.handleGotIt('binary');
    });

    expect(api.saveTermProgress).not.toHaveBeenCalled();
  });
});
