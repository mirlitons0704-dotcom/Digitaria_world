import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { InlineTermCard } from './InlineTermCard';
import { createMockTerm } from '../test/test-utils';

describe('InlineTermCard', () => {
  const mockTerm = createMockTerm({
    term: 'Binary',
    term_ja: '2進数',
    one_liner: '0と1だけで全てを表す数の体系',
    definition: '0と1の2つの数字だけを使います。',
    mechanism: 'How binary works',
    analogy: 'Like a light switch',
    pitfall: "Don't confuse with decimal",
    related_terms: ['bit', 'byte'],
  });

  const mockOnClose = vi.fn();
  const mockOnGotIt = vi.fn();

  beforeEach(() => {
    vi.resetAllMocks();
  });

  it('renders term name and one-liner', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} />);

    expect(screen.getByText('Binary')).toBeInTheDocument();
    expect(screen.getByText('0と1だけで全てを表す数の体系')).toBeInTheDocument();
  });

  it('renders definition', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} />);

    expect(screen.getByText('0と1の2つの数字だけを使います。')).toBeInTheDocument();
  });

  it('renders mechanism, analogy, and pitfall when present', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} />);

    expect(screen.getByText('How binary works')).toBeInTheDocument();
    expect(screen.getByText('Like a light switch')).toBeInTheDocument();
    expect(screen.getByText("Don't confuse with decimal")).toBeInTheDocument();
  });

  it('renders related terms', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} />);

    expect(screen.getByText('bit')).toBeInTheDocument();
    expect(screen.getByText('byte')).toBeInTheDocument();
  });

  it('hides optional sections when not present', () => {
    const minimalTerm = createMockTerm({
      mechanism: null,
      analogy: null,
      pitfall: null,
      related_terms: [],
    });

    render(<InlineTermCard term={minimalTerm} onClose={mockOnClose} />);

    expect(screen.queryByText('How it works')).not.toBeInTheDocument();
    expect(screen.queryByText('Analogy')).not.toBeInTheDocument();
    expect(screen.queryByText('Watch out')).not.toBeInTheDocument();
    expect(screen.queryByText('Related')).not.toBeInTheDocument();
  });

  it('calls onClose when close button is clicked', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} />);

    // The close button has an X icon; find by role
    const buttons = screen.getAllByRole('button');
    // First button is the close button (top-right)
    fireEvent.click(buttons[0]);

    expect(mockOnClose).toHaveBeenCalledTimes(1);
  });

  it('shows "理解した！" button when onGotIt is provided', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} onGotIt={mockOnGotIt} />);

    expect(screen.getByText('理解した！')).toBeInTheDocument();
  });

  it('does not show "理解した！" button when onGotIt is not provided', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} />);

    expect(screen.queryByText('理解した！')).not.toBeInTheDocument();
  });

  it('shows confirmation step before calling onGotIt', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} onGotIt={mockOnGotIt} />);

    // Click "理解した！"
    fireEvent.click(screen.getByText('理解した！'));

    // Now should see confirmation buttons
    expect(screen.getByText('キャンセル')).toBeInTheDocument();
    expect(screen.getByText('My Folderに追加')).toBeInTheDocument();

    // Click confirm
    fireEvent.click(screen.getByText('My Folderに追加'));

    expect(mockOnGotIt).toHaveBeenCalledTimes(1);
  });

  it('cancel returns to initial state', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} onGotIt={mockOnGotIt} />);

    fireEvent.click(screen.getByText('理解した！'));
    fireEvent.click(screen.getByText('キャンセル'));

    expect(screen.getByText('理解した！')).toBeInTheDocument();
    expect(mockOnGotIt).not.toHaveBeenCalled();
  });

  it('shows collected state when isCollected is true', () => {
    render(
      <InlineTermCard term={mockTerm} onClose={mockOnClose} onGotIt={mockOnGotIt} isCollected />
    );

    expect(screen.getByText('My Folder に追加済み')).toBeInTheDocument();
    expect(screen.queryByText('理解した！')).not.toBeInTheDocument();
  });

  it('shows loading state when saving', () => {
    render(<InlineTermCard term={mockTerm} onClose={mockOnClose} onGotIt={mockOnGotIt} saving />);

    // Click to confirm first
    fireEvent.click(screen.getByText('理解した！'));

    // The confirm button should show saving state
    expect(screen.getByText('保存中...')).toBeInTheDocument();
  });
});
