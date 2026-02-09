import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '../test/test-utils';
import { ChapterCard } from './ChapterCard';
import { createMockChapter } from '../test/test-utils';

describe('ChapterCard', () => {
  const mockChapter = createMockChapter();
  const mockOnClick = vi.fn();

  beforeEach(() => {
    mockOnClick.mockClear();
  });

  it('renders chapter title and subtitle', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} />);

    expect(screen.getByText(mockChapter.title)).toBeInTheDocument();
    expect(screen.getByText(mockChapter.subtitle!)).toBeInTheDocument();
  });

  it('displays chapter number correctly', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} />);

    expect(screen.getByText(`Chapter ${mockChapter.id}`)).toBeInTheDocument();
  });

  it('displays term count', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} />);

    expect(screen.getByText(`${mockChapter.term_count} terms`)).toBeInTheDocument();
  });

  it('displays category name', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} />);

    expect(screen.getByText(mockChapter.category_name)).toBeInTheDocument();
  });

  it('calls onClick when clicked', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} />);

    fireEvent.click(screen.getByRole('button'));

    expect(mockOnClick).toHaveBeenCalledTimes(1);
  });

  it('displays progress percentage', () => {
    const progress = 75;
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} progress={progress} />);

    expect(screen.getByText(`${progress}%`)).toBeInTheDocument();
  });

  it('shows default 0% progress when not specified', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} />);

    expect(screen.getByText('0%')).toBeInTheDocument();
  });

  it('is disabled when locked', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} isLocked />);

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();
  });

  it('does not call onClick when locked and clicked', () => {
    render(<ChapterCard chapter={mockChapter} onClick={mockOnClick} isLocked />);

    fireEvent.click(screen.getByRole('button'));

    expect(mockOnClick).not.toHaveBeenCalled();
  });

  it('renders epilogue label for chapter 17', () => {
    const epilogueChapter = createMockChapter({ id: 17, title: 'メモリーガーデン' });
    render(<ChapterCard chapter={epilogueChapter} onClick={mockOnClick} />);

    // Chapter 17 shows "Epilogue" instead of "Chapter 17"
    expect(screen.getByText('Epilogue')).toBeInTheDocument();
    expect(screen.getByText('メモリーガーデン')).toBeInTheDocument();
  });

  it('applies special styling when isSpecial is true', () => {
    const { container } = render(
      <ChapterCard chapter={mockChapter} onClick={mockOnClick} isSpecial />
    );

    const button = container.querySelector('button');
    expect(button?.className).toContain('amber');
  });

  it('applies themed background when chapterIndex is provided', () => {
    const { container } = render(
      <ChapterCard chapter={mockChapter} onClick={mockOnClick} chapterIndex={8} />
    );

    const button = container.querySelector('button');
    expect(button?.style.background).toContain('linear-gradient');
  });

  it('applies different themes for early and late chapters', () => {
    const { container: early } = render(
      <ChapterCard chapter={mockChapter} onClick={mockOnClick} chapterIndex={1} />
    );
    const { container: late } = render(
      <ChapterCard chapter={mockChapter} onClick={mockOnClick} chapterIndex={16} />
    );

    const earlyBg = early.querySelector('button')?.style.background;
    const lateBg = late.querySelector('button')?.style.background;
    expect(earlyBg).toContain('linear-gradient');
    expect(lateBg).toContain('linear-gradient');
    expect(earlyBg).not.toBe(lateBg);
  });

  it('falls back to default slate theme when no chapterIndex', () => {
    const { container } = render(
      <ChapterCard chapter={mockChapter} onClick={mockOnClick} />
    );

    const button = container.querySelector('button');
    expect(button?.className).toContain('slate');
    expect(button?.style.background).toBe('');
  });
});
