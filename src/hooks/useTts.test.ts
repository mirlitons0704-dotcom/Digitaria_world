import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useTts } from './useTts';
import type { StoryScene } from '../lib/database.types';

// Mock supabase (needed by geminiTts)
vi.mock('../lib/supabase', () => ({
  supabase: {
    auth: {
      getSession: vi.fn().mockResolvedValue({ data: { session: { access_token: 'test-token' } } }),
      refreshSession: vi.fn(),
    },
  },
}));

// Mock geminiTts
vi.mock('../lib/geminiTts', () => ({
  generateSpeech: vi.fn(),
  generateMultiSpeakerSpeech: vi.fn(),
}));

// Mock import.meta.env
vi.stubEnv('VITE_SUPABASE_URL', 'https://test.supabase.co');
vi.stubEnv('VITE_SUPABASE_ANON_KEY', 'test-key');

// Mock fetch for cache miss
const mockFetch = vi.fn().mockResolvedValue({ ok: false });
vi.stubGlobal('fetch', mockFetch);

// Mock Audio
class MockAudio {
  src = '';
  onended: (() => void) | null = null;
  onerror: (() => void) | null = null;
  play = vi.fn().mockResolvedValue(undefined);
  pause = vi.fn();
}

vi.stubGlobal('Audio', MockAudio);

// Mock URL.createObjectURL / revokeObjectURL
vi.stubGlobal('URL', {
  ...globalThis.URL,
  createObjectURL: vi.fn().mockReturnValue('blob:test'),
  revokeObjectURL: vi.fn(),
});

function createMockScene(overrides: Partial<StoryScene> = {}): StoryScene {
  return {
    id: 'scene-1',
    chapter_id: 1,
    scene_number: 1,
    title: 'Test Scene',
    title_en: null,
    content: 'Some test content for TTS',
    content_en: null,
    terms_introduced: [],
    character_ids: [],
    image_url: null,
    created_at: new Date().toISOString(),
    ...overrides,
  };
}

describe('useTts', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('returns idle status initially', () => {
    const scenes = [createMockScene()];
    const { result } = renderHook(() => useTts(scenes));

    expect(result.current.status).toBe('idle');
    expect(result.current.currentSceneIndex).toBe(0);
    expect(result.current.errorMessage).toBe(null);
  });

  it('returns idle status with empty scenes', () => {
    const { result } = renderHook(() => useTts([]));

    expect(result.current.status).toBe('idle');
  });

  it('exposes play, pause, and stop functions', () => {
    const scenes = [createMockScene()];
    const { result } = renderHook(() => useTts(scenes));

    expect(typeof result.current.play).toBe('function');
    expect(typeof result.current.pause).toBe('function');
    expect(typeof result.current.stop).toBe('function');
  });

  it('stop resets to idle state', () => {
    const scenes = [createMockScene()];
    const { result } = renderHook(() => useTts(scenes));

    act(() => {
      result.current.stop();
    });

    expect(result.current.status).toBe('idle');
    expect(result.current.currentSceneIndex).toBe(0);
    expect(result.current.errorMessage).toBe(null);
  });

  it('resets when scenes change', () => {
    const scenes1 = [createMockScene({ id: 'scene-1' })];
    const scenes2 = [createMockScene({ id: 'scene-2' })];

    const { result, rerender } = renderHook(({ scenes }) => useTts(scenes), {
      initialProps: { scenes: scenes1 },
    });

    expect(result.current.status).toBe('idle');

    rerender({ scenes: scenes2 });

    expect(result.current.status).toBe('idle');
    expect(result.current.currentSceneIndex).toBe(0);
  });

  it('resets when lang changes', () => {
    const scenes = [createMockScene()];

    const { result, rerender } = renderHook(({ lang }) => useTts(scenes, lang), {
      initialProps: { lang: 'ja' as 'ja' | 'en' },
    });

    expect(result.current.status).toBe('idle');

    rerender({ lang: 'en' as const });

    expect(result.current.status).toBe('idle');
    expect(result.current.currentSceneIndex).toBe(0);
  });
});
