import {
  Play,
  Pause,
  Volume2,
  VolumeX,
  ChevronDownIcon,
  Hand,
  Square,
  Loader2,
  Globe,
} from 'lucide-react';
import type { TtsStatus } from '../hooks/useTts';
import type { StoryLang } from '../hooks/useStoryLanguage';

const SPEED_OPTIONS = [
  { label: 'Super Slow', value: 0.25 },
  { label: 'Slow', value: 0.5 },
  { label: 'Normal', value: 1 },
  { label: 'Fast', value: 2 },
  { label: 'Turbo', value: 3.5 },
] as const;

export { SPEED_OPTIONS };

interface TeleprompterControlsProps {
  isAutoScroll: boolean;
  speedIndex: number;
  scrollProgress: number;
  storyLang: StoryLang;
  ttsStatus: TtsStatus;
  ttsCurrentSceneIndex: number;
  ttsErrorMessage: string | null;
  totalScenes: number;
  onToggleAutoScroll: () => void;
  onSpeedChange: (index: number) => void;
  onToggleLang: () => void;
  onAudioClick: () => void;
  onTtsStop: () => void;
}

export function TeleprompterControls({
  isAutoScroll,
  speedIndex,
  scrollProgress,
  storyLang,
  ttsStatus,
  ttsCurrentSceneIndex,
  ttsErrorMessage,
  totalScenes,
  onToggleAutoScroll,
  onSpeedChange,
  onToggleLang,
  onAudioClick,
  onTtsStop,
}: TeleprompterControlsProps) {
  return (
    <div className="relative">
      <div className="flex items-center justify-between px-4 py-2 bg-white/60 backdrop-blur-sm border-b border-gray-200/50">
        <div className="flex items-center gap-2">
          <button
            onClick={onToggleAutoScroll}
            aria-label={isAutoScroll ? 'オートスクロールを停止' : 'オートスクロールを開始'}
            className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
              isAutoScroll
                ? 'bg-teal-500 text-white shadow-md'
                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            }`}
          >
            {isAutoScroll ? (
              <>
                <Pause size={14} />
                <span className="hidden sm:inline">Auto</span>
              </>
            ) : (
              <>
                <Play size={14} />
                <span className="hidden sm:inline">Auto</span>
              </>
            )}
          </button>

          {isAutoScroll && (
            <div className="relative flex items-center">
              <select
                value={speedIndex}
                onChange={(e) => {
                  onSpeedChange(Number(e.target.value));
                  e.target.blur();
                }}
                className="appearance-none pl-2.5 pr-6 py-1.5 rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 text-xs font-medium transition-all cursor-pointer focus:outline-none focus:ring-2 focus:ring-teal-500/30"
              >
                {SPEED_OPTIONS.map((opt, i) => (
                  <option key={i} value={i}>
                    {opt.label}
                  </option>
                ))}
              </select>
              <ChevronDownIcon
                size={12}
                className="absolute right-2 pointer-events-none text-gray-500"
              />
            </div>
          )}

          {!isAutoScroll && (
            <span className="flex items-center gap-1 text-xs text-gray-500 ml-1">
              <Hand size={12} />
              <span className="hidden sm:inline">Scroll to read</span>
            </span>
          )}
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={onToggleLang}
            className="flex items-center gap-1 px-2.5 py-1.5 rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 text-xs font-medium transition-all"
            title={storyLang === 'ja' ? 'Switch to English' : '日本語に切り替え'}
            aria-label={storyLang === 'ja' ? 'Switch to English' : '日本語に切り替え'}
          >
            <Globe size={12} />
            <span>{storyLang === 'ja' ? 'EN' : 'JA'}</span>
          </button>

          <span className="text-xs text-gray-500 tabular-nums hidden sm:inline">
            {Math.round(scrollProgress * 100)}%
          </span>

          <div className="flex items-center gap-1.5">
            {(ttsStatus === 'playing' || ttsStatus === 'paused' || ttsStatus === 'loading') && (
              <button
                onClick={onTtsStop}
                className="flex items-center gap-1 px-2 py-1.5 rounded-full bg-gray-100 text-gray-500 hover:bg-red-50 hover:text-red-500 text-sm transition-all"
                title="Stop"
                aria-label="音声を停止"
              >
                <Square size={12} />
              </button>
            )}

            <div className="relative">
              <button
                onClick={onAudioClick}
                disabled={ttsStatus === 'loading'}
                aria-label={
                  ttsStatus === 'playing'
                    ? '音声を一時停止'
                    : ttsStatus === 'paused'
                      ? '音声を再開'
                      : '音声を再生'
                }
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-medium transition-all ${
                  ttsStatus === 'playing'
                    ? 'bg-teal-500 text-white shadow-md'
                    : ttsStatus === 'loading'
                      ? 'bg-amber-100 text-amber-600 cursor-wait'
                      : ttsStatus === 'error'
                        ? 'bg-red-50 text-red-500 hover:bg-red-100'
                        : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                }`}
              >
                {ttsStatus === 'loading' ? (
                  <Loader2 size={14} className="animate-spin" />
                ) : ttsStatus === 'playing' ? (
                  <Pause size={14} />
                ) : ttsStatus === 'error' ? (
                  <VolumeX size={14} />
                ) : (
                  <Volume2 size={14} />
                )}
                <span className="hidden sm:inline">
                  {ttsStatus === 'loading'
                    ? `Loading ${ttsCurrentSceneIndex + 1}/${totalScenes}`
                    : ttsStatus === 'playing'
                      ? `${ttsCurrentSceneIndex + 1}/${totalScenes}`
                      : ttsStatus === 'paused'
                        ? 'Resume'
                        : ttsStatus === 'error'
                          ? 'Retry'
                          : 'Listen'}
                </span>
              </button>

              {ttsStatus === 'error' && ttsErrorMessage && (
                <div className="absolute right-0 top-full mt-2 px-3 py-2 bg-red-800 text-white text-xs rounded-lg shadow-lg whitespace-nowrap z-50 animate-fade-in max-w-[200px] truncate">
                  {ttsErrorMessage}
                  <div className="absolute -top-1 right-4 w-2 h-2 bg-red-800 rotate-45" />
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="h-[2px] bg-gray-100">
        <div
          className="h-full bg-gradient-to-r from-teal-400 to-teal-600 transition-all duration-150 ease-out"
          style={{ width: `${scrollProgress * 100}%` }}
        />
      </div>
    </div>
  );
}
