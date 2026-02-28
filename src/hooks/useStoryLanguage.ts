import { useCallback, useSyncExternalStore } from 'react';

export type StoryLang = 'ja' | 'en';

const STORAGE_KEY = 'digitalia-story-lang';

/** Read the persisted preference (default: 'ja'). */
function getStoredLang(): StoryLang {
  const v = localStorage.getItem(STORAGE_KEY);
  return v === 'en' ? 'en' : 'ja';
}

// ── Tiny pub/sub so every hook instance stays in sync ──
const listeners = new Set<() => void>();
function subscribe(cb: () => void) {
  listeners.add(cb);
  return () => listeners.delete(cb);
}
let snapshot: StoryLang = getStoredLang();

function setLang(lang: StoryLang) {
  localStorage.setItem(STORAGE_KEY, lang);
  snapshot = lang;
  listeners.forEach((cb) => cb());
}

/**
 * Shared hook that returns the current story language and a toggle.
 * Every component using this hook re-renders together when the language changes.
 */
export function useStoryLanguage() {
  const lang = useSyncExternalStore(subscribe, () => snapshot);

  const toggle = useCallback(() => {
    setLang(lang === 'ja' ? 'en' : 'ja');
  }, [lang]);

  const set = useCallback((l: StoryLang) => setLang(l), []);

  return { storyLang: lang, toggleStoryLang: toggle, setStoryLang: set } as const;
}
