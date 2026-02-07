import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useChapter } from '../hooks/useChapters';
import { useTermsByChapter } from '../hooks/useTerms';
import { Layout } from '../components/Layout';
import { TermCard } from '../components/TermCard';
import { Loader2, ArrowLeft } from 'lucide-react';

export function TermListPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const chapterId = id ? parseInt(id, 10) : null;
  const { chapter, loading: chapterLoading } = useChapter(chapterId);
  const { terms, loading: termsLoading } = useTermsByChapter(chapterId);

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
            <p className="font-medium text-gray-800">{chapter.title}</p>
            <p className="text-xs text-gray-500">{terms.length} terms</p>
          </div>

          <div className="w-16" />
        </div>

        <div className="space-y-3">
          {terms.map((term) => (
            <TermCard
              key={term.id}
              term={term}
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
