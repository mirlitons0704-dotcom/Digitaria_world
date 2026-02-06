import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '../test/test-utils';
import { FlashCard } from './FlashCard';
import { createMockTerm } from '../test/test-utils';

describe('FlashCard', () => {
  const mockTerm = createMockTerm();
  const mockOnFlip = vi.fn();

  beforeEach(() => {
    mockOnFlip.mockClear();
  });

  describe('Front side (not flipped)', () => {
    it('displays term name', () => {
      render(<FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />);

      // Term appears in both front and back, so use getAllByText
      const termElements = screen.getAllByText(mockTerm.term);
      expect(termElements.length).toBeGreaterThan(0);
    });

    it('displays Japanese term', () => {
      render(<FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />);

      // Japanese term appears in both front and back
      const termJaElements = screen.getAllByText(mockTerm.term_ja);
      expect(termJaElements.length).toBeGreaterThan(0);
    });

    it('displays difficulty stars', () => {
      render(<FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />);

      // Difficulty 1 should have 1 active star
      const stars = screen.getAllByText('★');
      expect(stars).toHaveLength(3);
    });

    it('displays order index', () => {
      render(<FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />);

      expect(screen.getByText(`#${mockTerm.order_index}`)).toBeInTheDocument();
    });

    it('shows tap hint on front side', () => {
      render(<FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />);

      expect(screen.getByText('Tap to see definition')).toBeInTheDocument();
    });
  });

  describe('Back side (flipped)', () => {
    it('displays one-liner definition', () => {
      render(<FlashCard term={mockTerm} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.getByText(mockTerm.one_liner)).toBeInTheDocument();
    });

    it('displays full definition', () => {
      render(<FlashCard term={mockTerm} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.getByText(mockTerm.definition)).toBeInTheDocument();
    });

    it('displays analogy when available', () => {
      render(<FlashCard term={mockTerm} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.getByText(mockTerm.analogy!)).toBeInTheDocument();
      expect(screen.getByText('Analogy')).toBeInTheDocument();
    });

    it('displays pitfall when available', () => {
      render(<FlashCard term={mockTerm} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.getByText(mockTerm.pitfall!)).toBeInTheDocument();
      expect(screen.getByText('Watch out')).toBeInTheDocument();
    });

    it('displays related terms when available', () => {
      render(<FlashCard term={mockTerm} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.getByText('Related')).toBeInTheDocument();
      mockTerm.related_terms.forEach((relatedId) => {
        expect(screen.getByText(relatedId)).toBeInTheDocument();
      });
    });

    it('does not display analogy section when analogy is null', () => {
      const termWithoutAnalogy = createMockTerm({ analogy: null });
      render(<FlashCard term={termWithoutAnalogy} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.queryByText('Analogy')).not.toBeInTheDocument();
    });

    it('does not display pitfall section when pitfall is null', () => {
      const termWithoutPitfall = createMockTerm({ pitfall: null });
      render(<FlashCard term={termWithoutPitfall} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.queryByText('Watch out')).not.toBeInTheDocument();
    });

    it('does not display related section when related_terms is empty', () => {
      const termWithoutRelated = createMockTerm({ related_terms: [] });
      render(<FlashCard term={termWithoutRelated} isFlipped={true} onFlip={mockOnFlip} />);

      expect(screen.queryByText('Related')).not.toBeInTheDocument();
    });
  });

  describe('Interaction', () => {
    it('calls onFlip when clicked', () => {
      const { container } = render(
        <FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />
      );

      // Get the clickable card container directly
      const card = container.querySelector('.perspective-1000');
      fireEvent.click(card!);

      expect(mockOnFlip).toHaveBeenCalledTimes(1);
    });

    it('applies flip transform when isFlipped is true', () => {
      const { container } = render(
        <FlashCard term={mockTerm} isFlipped={true} onFlip={mockOnFlip} />
      );

      const flipContainer = container.querySelector('[style*="rotateY"]');
      expect(flipContainer).toBeInTheDocument();
      expect(flipContainer?.getAttribute('style')).toContain('rotateY(180deg)');
    });

    it('does not apply flip transform when isFlipped is false', () => {
      const { container } = render(
        <FlashCard term={mockTerm} isFlipped={false} onFlip={mockOnFlip} />
      );

      const flipContainer = container.querySelector('[style*="rotateY"]');
      expect(flipContainer).toBeInTheDocument();
      expect(flipContainer?.getAttribute('style')).toContain('rotateY(0deg)');
    });
  });

  describe('Difficulty levels', () => {
    it('shows correct stars for difficulty 1', () => {
      const easyTerm = createMockTerm({ difficulty: 1 });
      const { container } = render(
        <FlashCard term={easyTerm} isFlipped={false} onFlip={mockOnFlip} />
      );

      const activeStars = container.querySelectorAll('.text-amber-400');
      expect(activeStars.length).toBe(1);
    });

    it('shows correct stars for difficulty 2', () => {
      const mediumTerm = createMockTerm({ difficulty: 2 });
      const { container } = render(
        <FlashCard term={mediumTerm} isFlipped={false} onFlip={mockOnFlip} />
      );

      const activeStars = container.querySelectorAll('.text-amber-400');
      expect(activeStars.length).toBe(2);
    });

    it('shows correct stars for difficulty 3', () => {
      const hardTerm = createMockTerm({ difficulty: 3 });
      const { container } = render(
        <FlashCard term={hardTerm} isFlipped={false} onFlip={mockOnFlip} />
      );

      const activeStars = container.querySelectorAll('.text-amber-400');
      expect(activeStars.length).toBe(3);
    });
  });
});
