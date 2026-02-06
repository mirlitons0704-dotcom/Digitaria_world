import { useParams, useNavigate } from 'react-router-dom';
import { useChapterWithGuide } from '../hooks/useChapters';
import { useTermsByChapter } from '../hooks/useTerms';
import { Layout } from '../components/Layout';
import { Loader2, ArrowLeft, BookOpen, Layers, Sparkles } from 'lucide-react';

export function ChapterPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const chapterId = id ? parseInt(id, 10) : null;
  const { chapter, loading: chapterLoading } = useChapterWithGuide(chapterId);
  const { terms, loading: termsLoading } = useTermsByChapter(chapterId);

  const loading = chapterLoading || termsLoading;

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
      <div className="max-w-4xl mx-auto px-4 py-8">
        <button
          onClick={() => navigate('/home')}
          className="flex items-center gap-2 text-gray-500 hover:text-gray-700 mb-6 transition-colors"
        >
          <ArrowLeft size={18} />
          <span>Back to chapters</span>
        </button>

        <div className="bg-white/70 backdrop-blur-sm rounded-2xl p-6 md:p-8 shadow-lg mb-8">
          <div className="flex items-center gap-2 text-sm text-gray-500 mb-2">
            <span className="px-2 py-0.5 bg-teal-50 text-teal-600 rounded-full">
              {chapter.id === 17 ? 'Epilogue' : `Chapter ${chapter.id}`}
            </span>
            <span>{chapter.category_name}</span>
          </div>

          <h1 className="text-2xl md:text-3xl font-bold text-gray-800 mb-2">
            {chapter.title}
          </h1>

          {chapter.subtitle && (
            <p className="text-lg text-gray-600 mb-4">{chapter.subtitle}</p>
          )}

          {chapter.description && (
            <p className="text-gray-600 mb-6">{chapter.description}</p>
          )}

          <div className="flex items-center gap-4 text-sm text-gray-500">
            <span className="flex items-center gap-1">
              <BookOpen size={16} />
              {terms.length} terms
            </span>
            {chapter.guide && (
              <span className="flex items-center gap-1">
                <Sparkles size={16} />
                Guide: {chapter.guide.name}
              </span>
            )}
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
          <button
            onClick={() => navigate(`/chapter/${chapter.id}/flashcard`)}
            className="group relative overflow-hidden bg-gradient-to-br from-teal-500 to-teal-600 text-white rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all hover:-translate-y-0.5"
          >
            <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/2" />
            <Layers className="w-10 h-10 mb-3" />
            <h3 className="text-xl font-semibold mb-1">Flashcard Mode</h3>
            <p className="text-teal-100 text-sm">
              Learn terms with interactive cards
            </p>
          </button>

          <button
            onClick={() => navigate(`/chapter/${chapter.id}/terms`)}
            className="group relative overflow-hidden bg-gradient-to-br from-amber-500 to-orange-500 text-white rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all hover:-translate-y-0.5"
          >
            <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/2" />
            <BookOpen className="w-10 h-10 mb-3" />
            <h3 className="text-xl font-semibold mb-1">Term List</h3>
            <p className="text-amber-100 text-sm">
              Browse all terms in this chapter
            </p>
          </button>
        </div>

        <section>
          <h2 className="text-lg font-semibold text-gray-800 mb-4">
            Terms Preview
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
            {terms.slice(0, 8).map((term) => (
              <div
                key={term.id}
                className="bg-white/60 backdrop-blur-sm rounded-xl p-3 border border-gray-200/50"
              >
                <p className="font-medium text-gray-800 truncate">{term.term}</p>
                <p className="text-xs text-gray-500 truncate">{term.term_ja}</p>
              </div>
            ))}
            {terms.length > 8 && (
              <div className="bg-gray-100/60 rounded-xl p-3 flex items-center justify-center">
                <span className="text-sm text-gray-500">
                  +{terms.length - 8} more
                </span>
              </div>
            )}
          </div>
        </section>
      </div>
    </Layout>
  );
}
