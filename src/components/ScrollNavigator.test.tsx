import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '../test/test-utils';
import { ScrollNavigator } from './ScrollNavigator';

describe('ScrollNavigator', () => {
  const defaultProps = {
    isAtTop: false,
    isAtBottom: false,
    onScrollToTop: vi.fn(),
    onScrollUp: vi.fn(),
    onScrollDown: vi.fn(),
    onScrollToBottom: vi.fn(),
  };

  it('renders four navigation buttons', () => {
    render(<ScrollNavigator {...defaultProps} />);
    expect(screen.getAllByRole('button')).toHaveLength(4);
  });

  it('disables top buttons when at top', () => {
    render(<ScrollNavigator {...defaultProps} isAtTop={true} />);
    const buttons = screen.getAllByRole('button');

    expect(buttons[0]).toBeDisabled(); // scroll to top
    expect(buttons[1]).toBeDisabled(); // scroll up
    expect(buttons[2]).not.toBeDisabled(); // scroll down
    expect(buttons[3]).not.toBeDisabled(); // scroll to bottom
  });

  it('disables bottom buttons when at bottom', () => {
    render(<ScrollNavigator {...defaultProps} isAtBottom={true} />);
    const buttons = screen.getAllByRole('button');

    expect(buttons[0]).not.toBeDisabled();
    expect(buttons[1]).not.toBeDisabled();
    expect(buttons[2]).toBeDisabled(); // scroll down
    expect(buttons[3]).toBeDisabled(); // scroll to bottom
  });

  it('calls onScrollToTop when top button is clicked', () => {
    const onScrollToTop = vi.fn();
    render(<ScrollNavigator {...defaultProps} onScrollToTop={onScrollToTop} />);

    screen.getAllByRole('button')[0].click();
    expect(onScrollToTop).toHaveBeenCalledOnce();
  });

  it('calls onScrollDown when down button is clicked', () => {
    const onScrollDown = vi.fn();
    render(<ScrollNavigator {...defaultProps} onScrollDown={onScrollDown} />);

    screen.getAllByRole('button')[2].click();
    expect(onScrollDown).toHaveBeenCalledOnce();
  });
});
