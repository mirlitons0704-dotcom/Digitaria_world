import { useParams, useNavigate } from 'react-router-dom';
import { useChapterWithGuide } from '../hooks/useChapters';
import { useTermsByChapter } from '../hooks/useTerms';
import { useStoryScenes } from '../hooks/useStoryScenes';
import { Layout } from '../components/Layout';
import { StoryTeleprompter } from '../components/StoryTeleprompter';
import { Loader2, ArrowLeft, BookOpen, Sparkles } from 'lucide-react';

export function ChapterPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const chapterId = id ? parseInt(id, 10) : null;
  const { chapter, loading: chapterLoading } = useChapterWithGuide(chapterId);
  const { terms, loading: termsLoading } = useTermsByChapter(chapterId);
  const { scenes, loading: scenesLoading } = useStoryScenes(chapterId);

  const loading = chapterLoading || termsLoading || scenesLoading;

  if (loading) {
    return (
      <Layout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-500" />
        </div>
      </Layout>
    );
  }

  if (!chapter) {
    return (
      <Layout>
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
          <p className="text-gray-500">Chapter not found</p>
          <button
            onClick={() => navigate('/home')}
            className="text-teal-500 hover:text-teal-600"
          >
            Return to Home
          </button>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="flex flex-col -mb-8 h-[calc(100dvh-7rem)] md:h-[calc(100dvh-4rem)]">
        <div className="flex items-center gap-3 px-4 py-3 bg-white/50 backdrop-blur-sm border-b border-gray-200/40">
          <button
            onClick={() => navigate('/home')}
            className="p-1.5 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-all"
          >
            <ArrowLeft size={18} />
          </button>

          <div className="flex items-center gap-2 min-w-0 flex-1">
            <span className="shrink-0 px-2.5 py-0.5 bg-teal-50 text-teal-600 rounded-full text-sm font-semibold">
              {chapter.id === 17 ? 'Epilogue' : `Ch.${chapter.id}`}
            </span>
            <h1 className="text-base font-bold text-gray-800 truncate">
              {chapter.title}
            </h1>
            {chapter.subtitle && (
              <span className="hidden md:inline text-sm text-gray-400 truncate">
                {chapter.subtitle}
              </span>
            )}
          </div>

          <div className="hidden sm:flex items-center gap-3 text-xs text-gray-400 shrink-0">
            <span className="flex items-center gap-1">
              <BookOpen size={12} />
              {terms.length}
            </span>
            {chapter.guide && (
              <span className="flex items-center gap-1">
                <Sparkles size={12} />
                {chapter.guide.name}
              </span>
            )}
          </div>
        </div>

        <div className="flex-1 min-h-0 relative flex flex-col">
          <StoryTeleprompter scenes={scenes} chapterTitle={chapter.title} terms={terms} />

          <button
            onClick={() => navigate(`/chapter/${chapter.id}/terms`)}
            className="absolute bottom-4 right-4 z-30 flex items-center gap-2 px-4 py-2.5 rounded-full bg-white/90 backdrop-blur-md text-teal-700 text-sm font-semibold border border-teal-200/60 shadow-lg hover:shadow-xl hover:bg-white transition-all duration-300 hover:-translate-y-0.5"
          >
            <BookOpen size={16} />
            Term List
          </button>
        </div>
      </div>
    </Layout>
  );
}
