import { ReactElement, ReactNode } from 'react';
import { render, RenderOptions } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import type { Chapter, Term, Character } from '../lib/database.types';

// Create a QueryClient for testing (retry disabled for deterministic tests)
export function createTestQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: {
        retry: false,
        gcTime: Infinity,
      },
    },
  });
}

// Mock data factories
export function createMockChapter(overrides: Partial<Chapter> = {}): Chapter {
  return {
    id: 1,
    title: 'コンピュータの世界へ',
    title_en: null,
    subtitle: '0と1の冒険のはじまり',
    subtitle_en: null,
    category: 'basics',
    category_name: '基礎概念',
    category_icon: 'cpu',
    description: 'デジタリアへようこそ',
    guide_id: 'bit-kun',
    support_guide_id: null,
    term_count: 10,
    created_at: new Date().toISOString(),
    ...overrides,
  };
}

export function createMockTerm(overrides: Partial<Term> = {}): Term {
  return {
    id: 'binary',
    term: 'Binary',
    term_ja: '2進数',
    chapter_id: 1,
    order_index: 1,
    difficulty: 1,
    one_liner: '0と1だけで全てを表す数の体系',
    one_liner_en: null,
    definition: 'コンピュータが使う数の表現方法で、0と1の2つの数字だけを使います。',
    definition_en: null,
    mechanism: null,
    mechanism_en: null,
    analogy: '電気のスイッチのON/OFFのようなもの',
    analogy_en: null,
    pitfall: '10進数との混同に注意',
    pitfall_en: null,
    related_terms: ['bit', 'byte'],
    story_context: null,
    created_at: new Date().toISOString(),
    ...overrides,
  };
}

export function createMockCharacter(overrides: Partial<Character> = {}): Character {
  return {
    id: 'bit-kun',
    name: 'ビットくん',
    name_en: 'Bit-kun',
    role: 'メインガイド',
    personality: '好奇心旺盛、明るく元気',
    speech_style: '〜だよ、〜なんだ',
    appearance: '0と1が交互に点滅する小さな光の球体',
    chapter_appearance: 1,
    created_at: new Date().toISOString(),
    ...overrides,
  };
}

// Create multiple mock items
export function createMockChapters(count: number = 3): Chapter[] {
  return Array.from({ length: count }, (_, i) =>
    createMockChapter({
      id: i + 1,
      title: `Chapter ${i + 1}`,
      subtitle: `Subtitle ${i + 1}`,
    })
  );
}

export function createMockTerms(count: number = 5, chapterId: number = 1): Term[] {
  return Array.from({ length: count }, (_, i) =>
    createMockTerm({
      id: `term-${i + 1}`,
      term: `Term ${i + 1}`,
      term_ja: `用語 ${i + 1}`,
      chapter_id: chapterId,
      order_index: i + 1,
      difficulty: ((i % 3) + 1) as 1 | 2 | 3,
    })
  );
}

// Custom render with providers
interface WrapperProps {
  children: ReactNode;
}

function AllProviders({ children }: WrapperProps) {
  const queryClient = createTestQueryClient();
  return (
    <QueryClientProvider client={queryClient}>
      <BrowserRouter>{children}</BrowserRouter>
    </QueryClientProvider>
  );
}

// Wrapper for renderHook (hooks that use useQuery)
export function createQueryWrapper() {
  const queryClient = createTestQueryClient();
  return function QueryWrapper({ children }: WrapperProps) {
    return <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>;
  };
}

function customRender(ui: ReactElement, options?: Omit<RenderOptions, 'wrapper'>) {
  return render(ui, { wrapper: AllProviders, ...options });
}

// Re-export everything from testing-library
export * from '@testing-library/react';
export { customRender as render };
