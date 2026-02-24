import { describe, it, expect, beforeEach } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useStoryLanguage } from './useStoryLanguage';

const STORAGE_KEY = 'digitaria-story-lang';

describe('useStoryLanguage', () => {
  beforeEach(() => {
    // Reset module-level snapshot and localStorage to 'ja' before each test
    const { result } = renderHook(() => useStoryLanguage());
    act(() => result.current.setStoryLang('ja'));
    localStorage.removeItem(STORAGE_KEY);
  });

  it('defaults to "ja"', () => {
    const { result } = renderHook(() => useStoryLanguage());
    expect(result.current.storyLang).toBe('ja');
  });

  it('persists language to localStorage', () => {
    const { result } = renderHook(() => useStoryLanguage());
    act(() => result.current.setStoryLang('en'));
    expect(localStorage.getItem(STORAGE_KEY)).toBe('en');
  });

  it('toggleStoryLang switches between ja and en', () => {
    const { result } = renderHook(() => useStoryLanguage());

    act(() => result.current.toggleStoryLang());
    expect(result.current.storyLang).toBe('en');
    expect(localStorage.getItem(STORAGE_KEY)).toBe('en');

    act(() => result.current.toggleStoryLang());
    expect(result.current.storyLang).toBe('ja');
    expect(localStorage.getItem(STORAGE_KEY)).toBe('ja');
  });

  it('setStoryLang sets an explicit language', () => {
    const { result } = renderHook(() => useStoryLanguage());

    act(() => result.current.setStoryLang('en'));
    expect(result.current.storyLang).toBe('en');

    act(() => result.current.setStoryLang('ja'));
    expect(result.current.storyLang).toBe('ja');
  });

  it('syncs across multiple hook instances', () => {
    const { result: a } = renderHook(() => useStoryLanguage());
    const { result: b } = renderHook(() => useStoryLanguage());

    act(() => a.current.setStoryLang('en'));
    expect(b.current.storyLang).toBe('en');
  });
});
