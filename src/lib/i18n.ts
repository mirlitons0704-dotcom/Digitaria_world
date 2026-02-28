import type { StoryLang } from '../hooks/useStoryLanguage';

/**
 * Centralized UI translations for the Digitalia app.
 *
 * Auth pages are intentionally excluded (they stay English-only).
 * Database-driven text (chapter titles, scene titles, content) is
 * handled via `_en` columns and does NOT live here.
 */

const ui = {
  // ── Language toggle (shared by HomePage & StoryTeleprompter) ──
  'toggle.title': { ja: 'Switch to English', en: '日本語に切り替え' },
  'toggle.label': { ja: 'EN', en: 'JA' },

  // ── Home page ──
  'home.heroTitle': { ja: 'Your Journey Awaits', en: 'Your Journey Awaits' },
  'home.marquee': {
    ja: 'ビットくんとバイトさんが、あなたのプログラミング用語習得の旅を応援するよ! さあ、用語の理解で、世界が開けていく感覚を思いっきり味わって!!',
    en: 'Bit-kun and Byte-san are cheering you on your journey to learn programming terms! Go ahead and enjoy the feeling of the world opening up as you understand each term!!',
  },
  'home.mainStory': { ja: 'メインストーリー', en: 'Main Story' },
  'home.chapters16': { ja: '全16章', en: '16 Chapters' },
  'home.epilogue': { ja: 'エピローグ', en: 'Epilogue' },
  'home.memoryGarden': { ja: 'メモリーガーデン', en: 'Memory Garden' },

  // ── Story teleprompter ──
  'story.comingSoon': {
    ja: 'このチャプターのストーリーは準備中です…',
    en: "This chapter's story is coming soon...",
  },

  // ── Term card / Term list ──
  'term.tapHint': {
    ja: 'タップで用語カードを開こう → 🦋 バタフライをゲット！',
    en: 'Tap to open term card → 🦋 Get a butterfly!',
  },
  'term.howItWorks': { ja: '仕組み', en: 'How it works' },
  'term.analogy': { ja: 'たとえ', en: 'Analogy' },
  'term.pitfall': { ja: 'よくある間違い', en: 'Common mistake' },
  'term.watchOut': { ja: '注意', en: 'Watch out' },
  'term.related': { ja: '関連用語', en: 'Related terms' },
  'term.gotIt': { ja: '理解した！', en: 'Got it!' },
  'term.addToFolder': { ja: 'My Folderに追加', en: 'Add to My Folder' },
  'term.saving': { ja: '保存中...', en: 'Saving...' },
  'term.cancel': { ja: 'キャンセル', en: 'Cancel' },
  'term.addedToFolder': {
    ja: 'My Folder に追加済み 🦋',
    en: 'Added to My Folder 🦋',
  },
  'term.butterflyHint': {
    ja: '🦋 My Folder にバタフライが追加されます',
    en: '🦋 A butterfly will be added to My Folder',
  },
  'term.terms': { ja: '用語', en: 'terms' },
} as const;

// ── Derived types ──
export type UiKey = keyof typeof ui;

/**
 * Look up a static UI string by key.
 *
 * ```ts
 * t('home.mainStory', storyLang)  // → 'Main Story' | 'メインストーリー'
 * ```
 */
export function t(key: UiKey, lang: StoryLang): string {
  return ui[key][lang];
}

/**
 * Return a subtitle string that includes the dynamic term count.
 */
export function homeSubtitle(lang: StoryLang, termCount: number): string {
  return lang === 'en'
    ? `Explore ${termCount} programming terms across 17 chapters`
    : `17章にわたる${termCount}のプログラミング用語を探索しよう`;
}

// ── Category name mapping (English) ──
const categoryNameEn: Record<string, string> = {
  basics: 'Basic Concepts',
  fileTypes: 'File Types',
  dataTypes: 'Data Types & Structures',
  programming: 'Programming Basics',
  htmlCss: 'HTML & CSS',
  networking: 'URL & HTTP',
  javascript: 'JavaScript & TypeScript',
  react: 'React',
  uiComponents: 'UI Components',
  uiux: 'UI/UX & Design',
  cssFrameworks: 'CSS Frameworks',
  devTools: 'Dev Tools',
  packageManagement: 'Environment & Packages',
  git: 'Git & Version Control',
  backend: 'Backend',
  api: 'API',
  epilogue: 'Epilogue',
};

/**
 * Get the display name for a chapter category.
 */
export function categoryName(lang: StoryLang, category: string, jaFallback: string): string {
  return lang === 'en' ? (categoryNameEn[category] ?? jaFallback) : jaFallback;
}
