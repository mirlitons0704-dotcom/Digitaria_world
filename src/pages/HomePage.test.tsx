import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor, createMockChapters } from '../test/test-utils';
import { HomePage } from './HomePage';

// Mock hooks
vi.mock('../contexts/AuthContext', () => ({
  useAuth: vi.fn(() => ({
    user: { id: 'test-user', email: 'test@test.com' },
    profile: { username: 'tester' },
    loading: false,
    isAdmin: false,
    signOut: vi.fn(),
  })),
}));

vi.mock('../hooks/useChapters', () => ({
  useChapters: vi.fn(),
}));

vi.mock('../hooks/useStoryLanguage', () => ({
  useStoryLanguage: vi.fn(() => ({
    storyLang: 'ja',
    toggleStoryLang: vi.fn(),
    setStoryLang: vi.fn(),
  })),
}));

vi.mock('../hooks/useOnlineStatus', () => ({
  useOnlineStatus: vi.fn(() => true),
}));

import { useChapters } from '../hooks/useChapters';

const mockUseChapters = vi.mocked(useChapters);

describe('HomePage', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('shows loading spinner while chapters are loading', () => {
    mockUseChapters.mockReturnValue({
      chapters: [],
      loading: true,
      error: null,
      retry: vi.fn(),
    });

    render(<HomePage />);
    expect(document.querySelector('.animate-spin')).toBeTruthy();
  });

  it('shows error state with retry button', () => {
    const retryFn = vi.fn();
    mockUseChapters.mockReturnValue({
      chapters: [],
      loading: false,
      error: new Error('Network error'),
      retry: retryFn,
    });

    render(<HomePage />);
    expect(screen.getByText('Failed to load chapters')).toBeInTheDocument();
    expect(screen.getByText('Retry')).toBeInTheDocument();
  });

  it('renders chapter cards when data is loaded', async () => {
    const chapters = createMockChapters(3);
    mockUseChapters.mockReturnValue({
      chapters,
      loading: false,
      error: null,
      retry: vi.fn(),
    });

    render(<HomePage />);
    await waitFor(() => {
      // ChapterCard renders both "Chapter N" label and title; use getAllByText
      expect(screen.getAllByText('Chapter 1').length).toBeGreaterThanOrEqual(1);
      expect(screen.getAllByText('Chapter 2').length).toBeGreaterThanOrEqual(1);
      expect(screen.getAllByText('Chapter 3').length).toBeGreaterThanOrEqual(1);
    });
  });

  it('renders My Folder and Search buttons', () => {
    mockUseChapters.mockReturnValue({
      chapters: createMockChapters(1),
      loading: false,
      error: null,
      retry: vi.fn(),
    });

    render(<HomePage />);
    // Layout nav also renders these labels; use getAllByText
    expect(screen.getAllByText('My Folder').length).toBeGreaterThanOrEqual(1);
    expect(screen.getAllByText(/Search/).length).toBeGreaterThanOrEqual(1);
  });

  it('renders language toggle button', () => {
    mockUseChapters.mockReturnValue({
      chapters: createMockChapters(1),
      loading: false,
      error: null,
      retry: vi.fn(),
    });

    render(<HomePage />);
    expect(screen.getByText('EN')).toBeInTheDocument();
  });
});
