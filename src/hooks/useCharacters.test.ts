import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, waitFor } from '@testing-library/react';
import { useCharacters, useCharacter } from './useCharacters';
import * as api from '../lib/api';
import { createMockCharacter, createQueryWrapper } from '../test/test-utils';

vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

vi.mock('../lib/api');

describe('useCharacters', () => {
  const mockCharacters = [
    createMockCharacter({ id: 'bit-kun', name: 'ビットくん' }),
    createMockCharacter({ id: 'byte-san', name: 'バイトさん' }),
  ];

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns loading state initially', () => {
    vi.mocked(api.getCharacters).mockImplementation(() => new Promise(() => {}));

    const { result } = renderHook(() => useCharacters(), { wrapper: createQueryWrapper() });

    expect(result.current.loading).toBe(true);
    expect(result.current.characters).toEqual([]);
    expect(result.current.error).toBe(null);
  });

  it('returns characters after successful fetch', async () => {
    vi.mocked(api.getCharacters).mockResolvedValue(mockCharacters);

    const { result } = renderHook(() => useCharacters(), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.characters).toEqual(mockCharacters);
    expect(result.current.error).toBe(null);
  });

  it('returns error after failed fetch', async () => {
    const mockError = new Error('Failed to fetch characters');
    vi.mocked(api.getCharacters).mockRejectedValue(mockError);

    const { result } = renderHook(() => useCharacters(), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.characters).toEqual([]);
    expect(result.current.error).toEqual(mockError);
  });
});

describe('useCharacter', () => {
  const mockCharacter = createMockCharacter({ id: 'bit-kun' });

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns null when id is null', async () => {
    const { result } = renderHook(() => useCharacter(null), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.character).toBe(null);
    expect(api.getCharacter).not.toHaveBeenCalled();
  });

  it('fetches character when id is provided', async () => {
    vi.mocked(api.getCharacter).mockResolvedValue(mockCharacter);

    const { result } = renderHook(() => useCharacter('bit-kun'), {
      wrapper: createQueryWrapper(),
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.character).toEqual(mockCharacter);
    expect(api.getCharacter).toHaveBeenCalledWith('bit-kun');
  });

  it('returns error after failed fetch', async () => {
    const mockError = new Error('Character not found');
    vi.mocked(api.getCharacter).mockRejectedValue(mockError);

    const { result } = renderHook(() => useCharacter('bad-id'), {
      wrapper: createQueryWrapper(),
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.character).toBe(null);
    expect(result.current.error).toEqual(mockError);
  });
});
