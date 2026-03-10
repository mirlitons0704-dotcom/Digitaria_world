import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, waitFor, act } from '@testing-library/react';
import { useStoryScenes } from './useStoryScenes';
import * as api from '../lib/api';
import { createQueryWrapper } from '../test/test-utils';
import type { StoryScene } from '../lib/database.types';

vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

vi.mock('../lib/api');

function createMockScene(overrides: Partial<StoryScene> = {}): StoryScene {
  return {
    id: 'scene-1',
    chapter_id: 1,
    scene_number: 1,
    title: 'テストシーン',
    title_en: null,
    content: 'テスト内容',
    content_en: null,
    terms_introduced: [],
    character_ids: [],
    image_url: null,
    created_at: new Date().toISOString(),
    ...overrides,
  };
}

describe('useStoryScenes', () => {
  const mockScenes = [
    createMockScene({ id: 'scene-1', scene_number: 1 }),
    createMockScene({ id: 'scene-2', scene_number: 2 }),
  ];

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('returns loading state initially', () => {
    vi.mocked(api.getStoryScenes).mockImplementation(() => new Promise(() => {}));

    const { result } = renderHook(() => useStoryScenes(1), { wrapper: createQueryWrapper() });

    expect(result.current.loading).toBe(true);
    expect(result.current.scenes).toEqual([]);
    expect(result.current.error).toBe(null);
  });

  it('returns scenes after successful fetch', async () => {
    vi.mocked(api.getStoryScenes).mockResolvedValue(mockScenes);

    const { result } = renderHook(() => useStoryScenes(1), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.scenes).toEqual(mockScenes);
    expect(result.current.error).toBe(null);
    expect(api.getStoryScenes).toHaveBeenCalledWith(1);
  });

  it('does not fetch when chapterId is null', async () => {
    const { result } = renderHook(() => useStoryScenes(null), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.scenes).toEqual([]);
    expect(api.getStoryScenes).not.toHaveBeenCalled();
  });

  it('returns error after failed fetch', async () => {
    const mockError = new Error('Failed to fetch scenes');
    vi.mocked(api.getStoryScenes).mockRejectedValue(mockError);

    const { result } = renderHook(() => useStoryScenes(1), { wrapper: createQueryWrapper() });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
    });

    expect(result.current.scenes).toEqual([]);
    expect(result.current.error).toEqual(mockError);
  });

  it('retry recovers from error', async () => {
    const mockError = new Error('Network error');
    vi.mocked(api.getStoryScenes)
      .mockRejectedValueOnce(mockError)
      .mockResolvedValueOnce(mockScenes);

    const wrapper = createQueryWrapper();
    const { result } = renderHook(() => useStoryScenes(1), { wrapper });

    await waitFor(() => {
      expect(result.current.error).toEqual(mockError);
    });

    await act(async () => {
      result.current.retry();
    });

    await waitFor(() => {
      expect(result.current.loading).toBe(false);
      expect(result.current.error).toBe(null);
    });

    expect(result.current.scenes).toEqual(mockScenes);
  });
});
