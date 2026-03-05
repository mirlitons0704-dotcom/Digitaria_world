import { ChevronsUp, ChevronUp, ChevronDown, ChevronsDown } from 'lucide-react';

interface ScrollNavigatorProps {
  isAtTop: boolean;
  isAtBottom: boolean;
  onScrollToTop: () => void;
  onScrollUp: () => void;
  onScrollDown: () => void;
  onScrollToBottom: () => void;
}

export function ScrollNavigator({
  isAtTop,
  isAtBottom,
  onScrollToTop,
  onScrollUp,
  onScrollDown,
  onScrollToBottom,
}: ScrollNavigatorProps) {
  return (
    <div className="absolute right-3 top-1/2 -translate-y-1/2 flex flex-col gap-1.5 z-20">
      <button
        onClick={onScrollToTop}
        disabled={isAtTop}
        className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
          isAtTop
            ? 'bg-white/40 text-gray-300 cursor-default'
            : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
        }`}
        title="Scroll to top"
      >
        <ChevronsUp size={16} />
      </button>
      <button
        onClick={onScrollUp}
        disabled={isAtTop}
        className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
          isAtTop
            ? 'bg-white/40 text-gray-300 cursor-default'
            : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
        }`}
        title="Scroll up"
      >
        <ChevronUp size={16} />
      </button>
      <button
        onClick={onScrollDown}
        disabled={isAtBottom}
        className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
          isAtBottom
            ? 'bg-white/40 text-gray-300 cursor-default'
            : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
        }`}
        title="Scroll down"
      >
        <ChevronDown size={16} />
      </button>
      <button
        onClick={onScrollToBottom}
        disabled={isAtBottom}
        className={`p-1.5 rounded-full backdrop-blur-sm shadow-md transition-all ${
          isAtBottom
            ? 'bg-white/40 text-gray-300 cursor-default'
            : 'bg-white/80 text-gray-500 hover:bg-white hover:text-teal-600 hover:shadow-lg'
        }`}
        title="Scroll to bottom"
      >
        <ChevronsDown size={16} />
      </button>
    </div>
  );
}
