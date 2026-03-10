import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '../test/test-utils';
import { TermCard } from './TermCard';
import { createMockTerm } from '../test/test-utils';

// Mock i18n to return deterministic strings
vi.mock('../lib/i18n', () => ({
  t: (key: string, lang: string) => `${key}:${lang}`,
}));

describe('TermCard', () => {
  const mockTerm = createMockTerm();
  const mockOnToggle = vi.fn();

  beforeEach(() => {
    mockOnToggle.mockClear();
  });

  it('renders term name and japanese name', () => {
    render(<TermCard term={mockTerm} isExpanded={false} onToggle={mockOnToggle} />);

    expect(screen.getByText(mockTerm.term)).toBeInTheDocument();
    expect(screen.getByText(mockTerm.term_ja)).toBeInTheDocument();
  });

  it('renders order index', () => {
    render(<TermCard term={mockTerm} isExpanded={false} onToggle={mockOnToggle} />);

    expect(screen.getByText(`#${mockTerm.order_index}`)).toBeInTheDocument();
  });

  it('renders difficulty stars correctly', () => {
    const term = createMockTerm({ difficulty: 2 });
    const { container } = render(
      <TermCard term={term} isExpanded={false} onToggle={mockOnToggle} />
    );

    const stars = container.querySelectorAll('span.text-xs');
    const starSpans = Array.from(stars).filter((el) => el.textContent === '★');
    const activeStars = starSpans.filter((el) => el.className.includes('text-amber-400'));
    const inactiveStars = starSpans.filter((el) => el.className.includes('text-gray-200'));

    expect(activeStars).toHaveLength(2);
    expect(inactiveStars).toHaveLength(1);
  });

  it('calls onToggle when clicked', () => {
    render(<TermCard term={mockTerm} isExpanded={false} onToggle={mockOnToggle} />);

    fireEvent.click(screen.getByRole('button'));
    expect(mockOnToggle).toHaveBeenCalledTimes(1);
  });

  it('sets aria-expanded to false when collapsed', () => {
    render(<TermCard term={mockTerm} isExpanded={false} onToggle={mockOnToggle} />);

    expect(screen.getByRole('button')).toHaveAttribute('aria-expanded', 'false');
  });

  it('sets aria-expanded to true when expanded', () => {
    render(<TermCard term={mockTerm} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.getByRole('button')).toHaveAttribute('aria-expanded', 'true');
  });

  it('shows definition when expanded', () => {
    render(<TermCard term={mockTerm} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.getByText(mockTerm.definition)).toBeInTheDocument();
  });

  it('does not show definition when collapsed', () => {
    render(<TermCard term={mockTerm} isExpanded={false} onToggle={mockOnToggle} />);

    expect(screen.queryByText(mockTerm.definition)).not.toBeInTheDocument();
  });

  it('shows analogy when expanded and analogy exists', () => {
    render(<TermCard term={mockTerm} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.getByText(mockTerm.analogy!)).toBeInTheDocument();
  });

  it('shows pitfall when expanded and pitfall exists', () => {
    render(<TermCard term={mockTerm} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.getByText(mockTerm.pitfall!)).toBeInTheDocument();
  });

  it('shows related terms when expanded', () => {
    render(<TermCard term={mockTerm} isExpanded={true} onToggle={mockOnToggle} />);

    for (const related of mockTerm.related_terms) {
      expect(screen.getByText(related)).toBeInTheDocument();
    }
  });

  it('does not show mechanism section when mechanism is null', () => {
    const term = createMockTerm({ mechanism: null });
    render(<TermCard term={term} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.queryByText('term.howItWorks:ja')).not.toBeInTheDocument();
  });

  it('does not show analogy section when analogy is null', () => {
    const term = createMockTerm({ analogy: null });
    render(<TermCard term={term} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.queryByText('term.analogy:ja')).not.toBeInTheDocument();
  });

  it('does not show pitfall section when pitfall is null', () => {
    const term = createMockTerm({ pitfall: null });
    render(<TermCard term={term} isExpanded={true} onToggle={mockOnToggle} />);

    expect(screen.queryByText('term.pitfall:ja')).not.toBeInTheDocument();
  });

  it('shows English content when storyLang is en', () => {
    const term = createMockTerm({
      one_liner: 'Japanese one liner',
      one_liner_en: 'English one liner',
      definition: 'Japanese definition',
      definition_en: 'English definition',
    });
    render(<TermCard term={term} isExpanded={true} onToggle={mockOnToggle} storyLang="en" />);

    // one_liner appears twice in expanded view (header + detail), so use getAllByText
    expect(screen.getAllByText('English one liner').length).toBeGreaterThan(0);
    expect(screen.getByText('English definition')).toBeInTheDocument();
  });

  it('falls back to Japanese when English content is null', () => {
    const term = createMockTerm({
      one_liner: 'Japanese one liner',
      one_liner_en: null,
    });
    render(<TermCard term={term} isExpanded={false} onToggle={mockOnToggle} storyLang="en" />);

    expect(screen.getByText('Japanese one liner')).toBeInTheDocument();
  });
});
