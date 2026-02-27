import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useChapter } from '../hooks/useChapters';
import { useTermsByChapter } from '../hooks/useTerms';
import { useStoryLanguage } from '../hooks/useStoryLanguage';
import { Layout } from '../components/Layout';
import { TermCard } from '../components/TermCard';
import { t } from '../lib/i18n';
import { Loader2, ArrowLeft, Globe } from 'lucide-react';

export function TermListPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const chapterId = id ? parseInt(id, 10) : null;
  const { chapter, loading: chapterLoading } = useChapter(chapterId);
  const { terms, loading: termsLoading } = useTermsByChapter(chapterId);
  const { storyLang, toggleStoryLang } = useStoryLanguage();

  const [selectedTerm, setSelectedTerm] = useState<string | null>(null);

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
          <button onClick={() => navigate('/home')} className="text-teal-500 hover:text-teal-600">
            Return to Home
          </button>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="max-w-4xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6">
          <button
            onClick={() => navigate(`/chapter/${chapterId}`)}
            className="flex items-center gap-2 text-gray-500 hover:text-gray-700 transition-colors"
          >
            <ArrowLeft size={18} />
            <span className="hidden sm:inline">Back</span>
          </button>

          <div className="text-center">
            <p className="font-medium text-gray-800">
              {storyLang === 'en' && chapter.title_en ? chapter.title_en : chapter.title}
            </p>
            <p className="text-xs text-gray-500">
              {terms.length} {t('term.terms', storyLang)}
            </p>
          </div>

          <button
            onClick={toggleStoryLang}
            className="flex items-center gap-1 px-2.5 py-1.5 rounded-full bg-white/70 backdrop-blur-sm text-gray-600 hover:bg-white hover:shadow-sm text-xs font-medium transition-all border border-gray-200/60"
            title={t('toggle.title', storyLang)}
            aria-label={t('toggle.title', storyLang)}
          >
            <Globe size={14} className="text-teal-500" />
            <span>{t('toggle.label', storyLang)}</span>
          </button>
        </div>

        <div className="space-y-3">
          {terms.map((term) => (
            <TermCard
              key={term.id}
              term={term}
              storyLang={storyLang}
              isExpanded={selectedTerm === term.id}
              onToggle={() => setSelectedTerm(selectedTerm === term.id ? null : term.id)}
            />
          ))}
        </div>

        {terms.length === 0 && (
          <div className="text-center py-12">
            <p className="text-gray-500">No terms found</p>
          </div>
        )}
      </div>
    </Layout>
  );
}
