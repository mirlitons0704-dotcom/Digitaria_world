import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useSearchTerms } from '../hooks/useTerms';
import { useChapters } from '../hooks/useChapters';
import { Layout } from '../components/Layout';
import { TermCard } from '../components/TermCard';
import { Search, X, Loader2, BookOpen } from 'lucide-react';
import { TOTAL_TERMS } from '../lib/constants';

export function SearchPage() {
  const navigate = useNavigate();
  const [query, setQuery] = useState('');
  const [selectedTerm, setSelectedTerm] = useState<string | null>(null);
  const { results, loading } = useSearchTerms(query);
  const { chapters } = useChapters();

  const chapterMap = new Map(chapters.map((c) => [c.id, c]));

  return (
    <Layout>
      <div className="max-w-4xl mx-auto px-4 py-8">
        <header className="text-center mb-8">
          <h1 className="text-2xl font-bold text-gray-800 mb-2">Search Terms</h1>
          <p className="text-gray-500">
            Find any term across all {TOTAL_TERMS} programming concepts
          </p>
        </header>

        <div className="relative mb-8">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500" size={22} />
          <input
            type="text"
            placeholder="Search by term, Japanese, or description..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-full pl-12 pr-12 py-4 bg-white/80 backdrop-blur-sm rounded-2xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-teal-500/30 focus:border-teal-500 text-lg shadow-sm"
            autoFocus
          />
          {query && (
            <button
              onClick={() => setQuery('')}
              className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 p-1"
            >
              <X size={20} />
            </button>
          )}
        </div>

        {!query ? (
          <div className="text-center py-16">
            <Search className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <p className="text-gray-500">Start typing to search through all terms</p>
          </div>
        ) : loading ? (
          <div className="flex items-center justify-center py-16">
            <Loader2 className="w-8 h-8 animate-spin text-teal-500" />
          </div>
        ) : results.length === 0 ? (
          <div className="text-center py-16">
            <p className="text-gray-500 mb-4">No terms found for "{query}"</p>
            <p className="text-sm text-gray-500">Try searching with different keywords</p>
          </div>
        ) : (
          <>
            <p className="text-sm text-gray-500 mb-4" aria-live="polite">
              Found {results.length} result{results.length !== 1 ? 's' : ''}
            </p>

            <div className="space-y-3">
              {results.map((term) => {
                const chapter = chapterMap.get(term.chapter_id);
                return (
                  <div key={term.id} className="relative">
                    <TermCard
                      term={term}
                      isExpanded={selectedTerm === term.id}
                      onToggle={() => setSelectedTerm(selectedTerm === term.id ? null : term.id)}
                    />
                    {chapter && (
                      <button
                        onClick={() => navigate(`/chapter/${chapter.id}`)}
                        className="absolute top-4 right-12 flex items-center gap-1 text-xs text-gray-500 hover:text-teal-600 transition-colors"
                      >
                        <BookOpen size={14} />
                        <span>Ch.{chapter.id}</span>
                      </button>
                    )}
                  </div>
                );
              })}
            </div>
          </>
        )}
      </div>
    </Layout>
  );
}
