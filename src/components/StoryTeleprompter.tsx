import { useState, useRef, useEffect, useCallback, useMemo } from 'react';
import { ChevronsDown, ToggleLeft, ToggleRight, Check, ArrowRight, Home } from 'lucide-react';
import type { StoryScene, Term } from '../lib/database.types';
import { splitContentByMedia, type MediaSize } from '../lib/mediaMarker';
import { InlineTermCard } from './InlineTermCard';
import { TeleprompterControls } from './TeleprompterControls';
import { ScrollNavigator } from './ScrollNavigator';
import { useAuth } from '../contexts/AuthContext';
import { useTts } from '../hooks/useTts';
import { useStoryLanguage } from '../hooks/useStoryLanguage';
import { useAutoScroll } from '../hooks/useAutoScroll';
import { useTermCollection } from '../hooks/useTermCollection';

interface StoryTeleprompterProps {
  scenes: StoryScene[];
  chapterTitle: string;
  terms?: Term[];
  onNextChapter?: () => void;
  isLastChapter?: boolean;
  onBackToHome?: () => void;
}

const MANUAL_SCROLL_STEP = 200;

/** Map media size hint to Tailwind width class. */
const SIZE_CLASS: Record<MediaSize, string> = {
  sm: 'w-[35%]',
  md: 'w-[50%]',
  lg: 'w-[75%]',
  full: 'w-full',
};

export function StoryTeleprompter({
  scenes,
  chapterTitle,
  terms = [],
  onNextChapter,
  isLastChapter,
  onBackToHome,
}: StoryTeleprompterProps) {
  const { user } = useAuth();
  const { storyLang, toggleStoryLang } = useStoryLanguage();
  const sceneRefs = useRef<(HTMLDivElement | null)[]>([]);
  const [expandedTermId, setExpandedTermId] = useState<string | null>(null);

  const tts = useTts(scenes, storyLang);

  const {
    scrollRef,
    isAutoScroll,
    speedIndex,
    scrollProgress,
    isAtTop,
    isAtBottom,
    showScrollNav,
    toggleAutoScroll,
    stopAutoScroll,
    setSpeedIndex,
    scrollBy,
    scrollToTop,
    scrollToBottom,
  } = useAutoScroll({ scenes, tts, sceneRefs });

  const { collectedTermIds, savingTermId, saveError, handleGotIt } = useTermCollection(user?.id);

  useEffect(() => {
    sceneRefs.current = sceneRefs.current.slice(0, scenes.length);
  }, [scenes.length]);

  const termMap = useMemo(() => {
    const map = new Map<string, Term>();
    terms.forEach((t) => map.set(t.id, t));
    return map;
  }, [terms]);

  const toggleTerm = useCallback((termId: string) => {
    setExpandedTermId((prev) => (prev === termId ? null : termId));
  }, []);

  const handleAudioClick = () => {
    if (tts.status === 'playing') {
      tts.pause();
    } else if (tts.status === 'paused') {
      tts.play();
    } else if (tts.status === 'loading') {
      tts.stop();
    } else {
      tts.play();
    }
  };

  if (scenes.length === 0) {
    return (
      <div className="flex-1 flex items-center justify-center text-gray-400">
        <p>This chapter's story is coming soon...</p>
      </div>
    );
  }

  return (
    <div className="flex flex-col flex-1 min-h-0">
      {saveError && (
        <div
          role="alert"
          className="absolute top-4 left-1/2 -translate-x-1/2 z-50 px-4 py-2 bg-red-600 text-white text-sm rounded-lg shadow-lg animate-fade-in"
        >
          {saveError}
        </div>
      )}
      <TeleprompterControls
        isAutoScroll={isAutoScroll}
        speedIndex={speedIndex}
        scrollProgress={scrollProgress}
        storyLang={storyLang}
        ttsStatus={tts.status}
        ttsCurrentSceneIndex={tts.currentSceneIndex}
        ttsErrorMessage={tts.errorMessage}
        totalScenes={scenes.length}
        onToggleAutoScroll={toggleAutoScroll}
        onSpeedChange={setSpeedIndex}
        onToggleLang={toggleStoryLang}
        onAudioClick={handleAudioClick}
        onTtsStop={tts.stop}
      />

      <div className="relative flex-1 min-h-0">
        <div ref={scrollRef} className="teleprompter-container h-full overflow-y-auto">
          <div className="max-w-2xl mx-auto px-6 py-8">
            <h2 className="text-center text-xl font-semibold text-teal-600 mb-10 tracking-wide">
              {chapterTitle}
            </h2>

            {scenes.map((scene, index) => (
              <div
                key={scene.id}
                ref={(el) => {
                  sceneRefs.current[index] = el;
                }}
                className="scene-enter mb-12"
                style={{ animationDelay: `${index * 0.1}s` }}
              >
                {(scene.title || scene.title_en) && (
                  <div className="flex items-center gap-3 mb-4">
                    <div className="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent" />
                    <span className="text-sm font-semibold text-gray-500 tracking-wide whitespace-nowrap">
                      {storyLang === 'en' && scene.title_en ? scene.title_en : scene.title}
                    </span>
                    <div className="h-px flex-1 bg-gradient-to-r from-transparent via-gray-300 to-transparent" />
                  </div>
                )}

                {scene.image_url && (
                  <div className="scene-image-enter flex justify-center my-6">
                    <img
                      src={scene.image_url}
                      alt={scene.title || 'シーン画像'}
                      className={`${SIZE_CLASS['md']} object-contain drop-shadow-lg`}
                      loading="lazy"
                    />
                  </div>
                )}

                <div className="text-gray-700 text-lg leading-loose whitespace-pre-line">
                  {splitContentByMedia(
                    storyLang === 'en' && scene.content_en ? scene.content_en : scene.content
                  ).map((segment, i) =>
                    typeof segment === 'string' ? (
                      segment
                    ) : (
                      <span key={i} className="flex justify-center my-6">
                        <img
                          src={segment.src}
                          alt=""
                          className={`${SIZE_CLASS[segment.size ?? 'md']} object-contain drop-shadow-lg`}
                          loading="lazy"
                        />
                      </span>
                    )
                  )}
                </div>

                {scene.terms_introduced.length > 0 && (
                  <div className="mt-4">
                    <div className="flex items-center gap-2 flex-wrap">
                      {scene.terms_introduced.map((termId) => {
                        const term = termMap.get(termId);
                        const isExpanded = expandedTermId === termId;
                        const isCollected = collectedTermIds.has(termId);
                        return (
                          <button
                            key={termId}
                            onClick={() => toggleTerm(termId)}
                            className={`term-toggle-pill inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold transition-all duration-300 ${
                              isExpanded
                                ? 'term-toggle-pill-active text-white shadow-md'
                                : isCollected
                                  ? 'term-toggle-pill-collected text-emerald-400'
                                  : 'term-toggle-pill-inactive text-emerald-700 hover:shadow-sm'
                            }`}
                          >
                            {isExpanded ? (
                              <ToggleRight size={13} />
                            ) : isCollected ? (
                              <Check size={13} />
                            ) : (
                              <ToggleLeft size={13} />
                            )}
                            {term ? term.term : termId}
                          </button>
                        );
                      })}
                    </div>
                    {/* Hint: show when scene has uncollected terms and no card is open */}
                    {!expandedTermId &&
                      scene.terms_introduced.some((tid) => !collectedTermIds.has(tid)) && (
                        <p className="mt-2 text-[11px] text-emerald-600/70 flex items-center gap-1">
                          <span>👆</span>
                          <span>
                            {storyLang === 'en'
                              ? 'Tap to open a term card →'
                              : 'タップで用語カードを開こう →'}{' '}
                            <span className="inline-flex items-center gap-0.5">
                              🦋 {storyLang === 'en' ? 'Earn a butterfly!' : 'バタフライをゲット！'}
                            </span>
                          </span>
                        </p>
                      )}
                    {scene.terms_introduced.map((termId) => {
                      const term = termMap.get(termId);
                      if (!term || expandedTermId !== termId) return null;
                      return (
                        <InlineTermCard
                          key={`card-${termId}`}
                          term={term}
                          storyLang={storyLang}
                          isCollected={collectedTermIds.has(termId)}
                          saving={savingTermId === termId}
                          onClose={() => setExpandedTermId(null)}
                          onGotIt={() => handleGotIt(termId)}
                        />
                      );
                    })}
                  </div>
                )}
              </div>
            ))}

            <div className="flex flex-col items-center gap-6 py-12">
              <div className="inline-flex items-center gap-2 text-gray-300">
                <div className="h-px w-12 bg-gray-200" />
                <ChevronsDown size={16} />
                <div className="h-px w-12 bg-gray-200" />
              </div>

              {isLastChapter
                ? onBackToHome && (
                    <button
                      onClick={onBackToHome}
                      className="inline-flex items-center gap-2.5 px-6 py-3 rounded-full bg-gray-700 text-gray-100 text-sm font-semibold shadow-lg hover:bg-gray-600 hover:shadow-xl transition-all duration-300 hover:-translate-y-0.5"
                    >
                      <Home size={16} />
                      Back to Home
                    </button>
                  )
                : onNextChapter && (
                    <button
                      onClick={onNextChapter}
                      className="inline-flex items-center gap-2.5 px-6 py-3 rounded-full bg-gray-700 text-gray-100 text-sm font-semibold shadow-lg hover:bg-gray-600 hover:shadow-xl transition-all duration-300 hover:-translate-y-0.5"
                    >
                      <ArrowRight size={16} />
                      Go Next Chapter
                    </button>
                  )}
            </div>
          </div>
        </div>

        {showScrollNav && !isAutoScroll && (
          <ScrollNavigator
            isAtTop={isAtTop}
            isAtBottom={isAtBottom}
            onScrollToTop={scrollToTop}
            onScrollUp={() => scrollBy(-MANUAL_SCROLL_STEP)}
            onScrollDown={() => scrollBy(MANUAL_SCROLL_STEP)}
            onScrollToBottom={scrollToBottom}
          />
        )}

        {saveError && (
          <div
            role="alert"
            className="absolute top-3 left-1/2 -translate-x-1/2 z-30 px-4 py-2 bg-red-600 text-white text-sm rounded-lg shadow-lg"
          >
            {saveError}
          </div>
        )}

        {isAutoScroll && !isAtBottom && (
          <div className="absolute bottom-6 left-1/2 -translate-x-1/2 z-20">
            <button
              onClick={stopAutoScroll}
              className="px-4 py-2 bg-gray-800/80 text-white text-sm rounded-full backdrop-blur-sm shadow-lg hover:bg-gray-800 transition-all"
            >
              Tap to stop
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
