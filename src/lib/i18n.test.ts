import { describe, it, expect } from 'vitest';
import { t, homeSubtitle, categoryName } from './i18n';

describe('i18n', () => {
  describe('t()', () => {
    it('returns Japanese text for "ja"', () => {
      expect(t('home.mainStory', 'ja')).toBe('メインストーリー');
    });

    it('returns English text for "en"', () => {
      expect(t('home.mainStory', 'en')).toBe('Main Story');
    });

    it('returns toggle labels correctly', () => {
      expect(t('toggle.label', 'ja')).toBe('EN');
      expect(t('toggle.label', 'en')).toBe('JA');
    });
  });

  describe('homeSubtitle()', () => {
    it('includes term count in English', () => {
      const result = homeSubtitle('en', 520);
      expect(result).toContain('520');
      expect(result).toContain('17 chapters');
    });

    it('includes term count in Japanese', () => {
      const result = homeSubtitle('ja', 520);
      expect(result).toContain('520');
      expect(result).toContain('17章');
    });
  });

  describe('categoryName()', () => {
    it('returns English name for known categories', () => {
      expect(categoryName('en', 'basics', '基礎概念')).toBe('Basic Concepts');
      expect(categoryName('en', 'react', 'React')).toBe('React');
    });

    it('returns Japanese fallback for "ja"', () => {
      expect(categoryName('ja', 'basics', '基礎概念')).toBe('基礎概念');
    });

    it('returns Japanese fallback for unknown categories in "en"', () => {
      expect(categoryName('en', 'unknown', '不明')).toBe('不明');
    });
  });
});
