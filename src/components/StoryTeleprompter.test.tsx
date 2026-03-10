import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '../test/test-utils';
import { StoryTeleprompter } from './StoryTeleprompter';
import type { StoryScene, Term } from '../lib/database.types';
import { createMockTerm } from '../test/test-utils';

// Mock AuthContext
vi.mock('../contexts/AuthContext', () => ({
  useAuth: () => ({
    user: { id: 'user-1' },
  }),
}));

vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

// Mock hooks
vi.mock('../hooks/useTts', () => ({
  useTts: () => ({
    status: 'idle' as const,
    currentSceneIndex: 0,
    errorMessage: null,
    play: vi.fn(),
    pause: vi.fn(),
    stop: vi.fn(),
  }),
}));

vi.mock('../hooks/useStoryLanguage', () => ({
  useStoryLanguage: () => ({
    storyLang: 'ja' as const,
    toggleStoryLang: vi.fn(),
  }),
}));

vi.mock('../hooks/useAutoScroll', () => ({
  useAutoScroll: () => ({
    scrollRef: { current: null },
    isAutoScroll: false,
    speedIndex: 1,
    scrollProgress: 0,
    isAtTop: true,
    isAtBottom: false,
    showScrollNav: false,
    toggleAutoScroll: vi.fn(),
    stopAutoScroll: vi.fn(),
    setSpeedIndex: vi.fn(),
    scrollBy: vi.fn(),
    scrollToTop: vi.fn(),
    scrollToBottom: vi.fn(),
  }),
}));

vi.mock('../hooks/useTermCollection', () => ({
  useTermCollection: () => ({
    collectedTermIds: new Set<string>(),
    savingTermId: null,
    saveError: null,
    handleGotIt: vi.fn(),
  }),
}));

vi.mock('../lib/mediaMarker', () => ({
  splitContentByMedia: (content: string) => [content],
}));

function createMockScene(overrides: Partial<StoryScene> = {}): StoryScene {
  return {
    id: 'scene-1',
    chapter_id: 1,
    scene_number: 1,
    title: 'Scene Title',
    title_en: null,
    content: 'Scene content text',
    content_en: null,
    terms_introduced: [],
    character_ids: [],
    image_url: null,
    created_at: new Date().toISOString(),
    ...overrides,
  };
}

describe('StoryTeleprompter', () => {
  it('shows coming soon message when scenes are empty', () => {
    render(<StoryTeleprompter scenes={[]} chapterTitle="Chapter 1" />);

    expect(screen.getByText("This chapter's story is coming soon...")).toBeInTheDocument();
  });

  it('renders chapter title', () => {
    const scenes = [createMockScene()];
    render(<StoryTeleprompter scenes={scenes} chapterTitle="テストチャプター" />);

    expect(screen.getByText('テストチャプター')).toBeInTheDocument();
  });

  it('renders scene title', () => {
    const scenes = [createMockScene({ title: 'Scene One' })];
    render(<StoryTeleprompter scenes={scenes} chapterTitle="Chapter 1" />);

    expect(screen.getByText('Scene One')).toBeInTheDocument();
  });

  it('renders scene content', () => {
    const scenes = [createMockScene({ content: 'Hello world from scene' })];
    render(<StoryTeleprompter scenes={scenes} chapterTitle="Chapter 1" />);

    expect(screen.getByText('Hello world from scene')).toBeInTheDocument();
  });

  it('renders multiple scenes', () => {
    const scenes = [
      createMockScene({ id: 's1', title: 'First Scene', content: 'First content' }),
      createMockScene({ id: 's2', title: 'Second Scene', content: 'Second content' }),
    ];
    render(<StoryTeleprompter scenes={scenes} chapterTitle="Chapter 1" />);

    expect(screen.getByText('First Scene')).toBeInTheDocument();
    expect(screen.getByText('Second Scene')).toBeInTheDocument();
  });

  it('renders term toggle pills when scene has terms', () => {
    const mockTerms: Term[] = [createMockTerm({ id: 'binary', term: 'Binary' })];
    const scenes = [createMockScene({ terms_introduced: ['binary'] })];

    render(<StoryTeleprompter scenes={scenes} chapterTitle="Chapter 1" terms={mockTerms} />);

    expect(screen.getByText('Binary')).toBeInTheDocument();
  });

  it('shows term id as fallback when term not found in terms list', () => {
    const scenes = [createMockScene({ terms_introduced: ['unknown-term'] })];

    render(<StoryTeleprompter scenes={scenes} chapterTitle="Chapter 1" terms={[]} />);

    expect(screen.getByText('unknown-term')).toBeInTheDocument();
  });

  it('renders Go Next Chapter button when onNextChapter is provided', () => {
    const scenes = [createMockScene()];
    const onNext = vi.fn();

    render(
      <StoryTeleprompter
        scenes={scenes}
        chapterTitle="Chapter 1"
        onNextChapter={onNext}
        isLastChapter={false}
      />
    );

    const nextButton = screen.getByText('Go Next Chapter');
    expect(nextButton).toBeInTheDocument();

    fireEvent.click(nextButton);
    expect(onNext).toHaveBeenCalledTimes(1);
  });

  it('renders Back to Home button when isLastChapter is true', () => {
    const scenes = [createMockScene()];
    const onHome = vi.fn();

    render(
      <StoryTeleprompter
        scenes={scenes}
        chapterTitle="Final Chapter"
        isLastChapter={true}
        onBackToHome={onHome}
      />
    );

    const homeButton = screen.getByText('Back to Home');
    expect(homeButton).toBeInTheDocument();

    fireEvent.click(homeButton);
    expect(onHome).toHaveBeenCalledTimes(1);
  });

  it('renders scene image when image_url is provided', () => {
    const scenes = [
      createMockScene({ image_url: 'https://example.com/image.png', title: 'With Image' }),
    ];
    render(<StoryTeleprompter scenes={scenes} chapterTitle="Chapter 1" />);

    const img = screen.getByAltText('With Image');
    expect(img).toHaveAttribute('src', 'https://example.com/image.png');
  });
});
