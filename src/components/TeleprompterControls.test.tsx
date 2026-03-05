import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '../test/test-utils';
import { TeleprompterControls } from './TeleprompterControls';

const defaultProps = {
  isAutoScroll: false,
  speedIndex: 2,
  scrollProgress: 0.5,
  storyLang: 'ja' as const,
  ttsStatus: 'idle' as const,
  ttsCurrentSceneIndex: 0,
  ttsErrorMessage: null,
  totalScenes: 5,
  onToggleAutoScroll: vi.fn(),
  onSpeedChange: vi.fn(),
  onToggleLang: vi.fn(),
  onAudioClick: vi.fn(),
  onTtsStop: vi.fn(),
};

describe('TeleprompterControls', () => {
  it('renders auto-scroll toggle button', () => {
    render(<TeleprompterControls {...defaultProps} />);
    expect(screen.getByLabelText('オートスクロールを開始')).toBeInTheDocument();
  });

  it('shows pause label when auto-scroll is active', () => {
    render(<TeleprompterControls {...defaultProps} isAutoScroll={true} />);
    expect(screen.getByLabelText('オートスクロールを停止')).toBeInTheDocument();
  });

  it('shows speed selector when auto-scroll is active', () => {
    render(<TeleprompterControls {...defaultProps} isAutoScroll={true} />);
    expect(screen.getByRole('combobox')).toBeInTheDocument();
  });

  it('renders language toggle with EN label for ja', () => {
    render(<TeleprompterControls {...defaultProps} storyLang="ja" />);
    expect(screen.getByText('EN')).toBeInTheDocument();
  });

  it('renders language toggle with JA label for en', () => {
    render(<TeleprompterControls {...defaultProps} storyLang="en" />);
    expect(screen.getByText('JA')).toBeInTheDocument();
  });

  it('renders Listen button when TTS is idle', () => {
    render(<TeleprompterControls {...defaultProps} ttsStatus="idle" />);
    expect(screen.getByLabelText('音声を再生')).toBeInTheDocument();
  });

  it('renders pause label when TTS is playing', () => {
    render(<TeleprompterControls {...defaultProps} ttsStatus="playing" />);
    expect(screen.getByLabelText('音声を一時停止')).toBeInTheDocument();
  });

  it('shows stop button when TTS is playing', () => {
    render(<TeleprompterControls {...defaultProps} ttsStatus="playing" />);
    expect(screen.getByLabelText('音声を停止')).toBeInTheDocument();
  });

  it('calls onToggleAutoScroll when auto button is clicked', () => {
    const onToggleAutoScroll = vi.fn();
    render(<TeleprompterControls {...defaultProps} onToggleAutoScroll={onToggleAutoScroll} />);

    screen.getByLabelText('オートスクロールを開始').click();
    expect(onToggleAutoScroll).toHaveBeenCalledOnce();
  });

  it('calls onToggleLang when language button is clicked', () => {
    const onToggleLang = vi.fn();
    render(<TeleprompterControls {...defaultProps} onToggleLang={onToggleLang} />);

    screen.getByText('EN').click();
    expect(onToggleLang).toHaveBeenCalledOnce();
  });
});
