import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '../test/test-utils';
import { ButterflyCard, ButterflyRow, TermDetail, diffColor } from './ButterflyCollection';
import type { CollectedTerm } from './ButterflyCollection';
import { createMockTerm } from '../test/test-utils';

function createCollectedTerm(overrides: Partial<CollectedTerm> = {}): CollectedTerm {
  return {
    ...createMockTerm(),
    collected_at: new Date().toISOString(),
    ...overrides,
  };
}

describe('diffColor', () => {
  it('returns emerald for difficulty 1', () => {
    expect(diffColor(1).text).toBe('text-emerald-600');
  });

  it('returns blue for difficulty 2', () => {
    expect(diffColor(2).text).toBe('text-blue-600');
  });

  it('returns violet for difficulty 3', () => {
    expect(diffColor(3).text).toBe('text-violet-600');
  });

  it('falls back to emerald for unknown difficulty', () => {
    expect(diffColor(99).text).toBe('text-emerald-600');
  });
});

describe('TermDetail', () => {
  it('renders term name and definition', () => {
    const term = createMockTerm({ term: 'Binary', definition: 'A number system' });
    render(<TermDetail term={term} onClose={vi.fn()} />);

    expect(screen.getByText('Binary')).toBeInTheDocument();
    expect(screen.getByText('A number system')).toBeInTheDocument();
  });

  it('renders mechanism when present', () => {
    const term = createMockTerm({ mechanism: 'Uses 0 and 1' });
    render(<TermDetail term={term} onClose={vi.fn()} />);

    expect(screen.getByText('Uses 0 and 1')).toBeInTheDocument();
  });

  it('calls onClose when close button is clicked', async () => {
    const onClose = vi.fn();
    const term = createMockTerm();
    render(<TermDetail term={term} onClose={onClose} />);

    const closeButton = screen.getByRole('button');
    closeButton.click();
    expect(onClose).toHaveBeenCalledOnce();
  });
});

describe('ButterflyCard', () => {
  it('renders term name and Japanese name', () => {
    const term = createCollectedTerm({ term: 'API', term_ja: 'エーピーアイ' });
    render(<ButterflyCard term={term} isExpanded={false} onToggle={vi.fn()} />);

    expect(screen.getByText('API')).toBeInTheDocument();
    expect(screen.getByText('エーピーアイ')).toBeInTheDocument();
  });

  it('shows TermDetail when expanded', () => {
    const term = createCollectedTerm({ definition: 'Application interface' });
    render(<ButterflyCard term={term} isExpanded={true} onToggle={vi.fn()} />);

    expect(screen.getByText('Application interface')).toBeInTheDocument();
  });

  it('calls onToggle when clicked', () => {
    const onToggle = vi.fn();
    const term = createCollectedTerm();
    render(<ButterflyCard term={term} isExpanded={false} onToggle={onToggle} />);

    screen.getAllByRole('button')[0].click();
    expect(onToggle).toHaveBeenCalledOnce();
  });
});

describe('ButterflyRow', () => {
  it('renders term name and one-liner', () => {
    const term = createCollectedTerm({ term: 'Git', one_liner: 'Version control' });
    render(<ButterflyRow term={term} isExpanded={false} onToggle={vi.fn()} />);

    expect(screen.getByText('Git')).toBeInTheDocument();
    expect(screen.getByText('Version control')).toBeInTheDocument();
  });

  it('shows TermDetail when expanded', () => {
    const term = createCollectedTerm({ definition: 'A distributed VCS' });
    render(<ButterflyRow term={term} isExpanded={true} onToggle={vi.fn()} />);

    expect(screen.getByText('A distributed VCS')).toBeInTheDocument();
  });
});
