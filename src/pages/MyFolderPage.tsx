import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { useChapters } from '../hooks/useChapters';
import { Layout } from '../components/Layout';
import { getUserCollectedTerms, getTermsByIds } from '../lib/api';
import { Term, Chapter } from '../lib/database.types';
import { Loader2, Folder, Sparkles, Grid3X3, List, ChevronRight } from 'lucide-react';

interface CollectedTerm extends Term {
  collected_at: string;
}

interface ChapterCollection {
  chapter: Chapter;
  terms: CollectedTerm[];
}

export function MyFolderPage() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const { chapters } = useChapters();
  const [collections, setCollections] = useState<ChapterCollection[]>([]);
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [expandedChapter, setExpandedChapter] = useState<number | null>(null);
  const [totalButterflies, setTotalButterflies] = useState(0);

  useEffect(() => {
    if (!user) return;

    const userId = user.id;

    async function fetchCollections() {
      setLoading(true);

      try {
        const progress = await getUserCollectedTerms(userId);

        if (!progress || progress.length === 0) {
          setCollections([]);
          setTotalButterflies(0);
          setLoading(false);
          return;
        }

        const termIds = progress.map(p => p.term_id);
        const progressMap = new Map(progress.map(p => [p.term_id, p.created_at]));

        const terms = await getTermsByIds(termIds);

        if (!terms || terms.length === 0) {
          setCollections([]);
          setLoading(false);
          return;
        }

        const collectedTerms: CollectedTerm[] = terms.map(term => ({
          ...term,
          collected_at: progressMap.get(term.id) || new Date().toISOString(),
        }));

        const chapterMap = new Map<number, CollectedTerm[]>();
        collectedTerms.forEach(term => {
          const existing = chapterMap.get(term.chapter_id) || [];
          existing.push(term);
          chapterMap.set(term.chapter_id, existing);
        });

        const result: ChapterCollection[] = chapters
          .filter(chapter => chapterMap.has(chapter.id))
          .map(chapter => ({
            chapter,
            terms: chapterMap.get(chapter.id)!.sort((a, b) => a.order_index - b.order_index),
          }));

        setCollections(result);
        setTotalButterflies(collectedTerms.length);
      } catch (error) {
        console.error('Failed to fetch collections:', error);
        setCollections([]);
      } finally {
        setLoading(false);
      }
    }

    fetchCollections();
  }, [user, chapters]);

  if (!user) {
    navigate('/');
    return null;
  }

  if (loading) {
    return (
      <Layout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-500" />
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="max-w-4xl mx-auto px-4 py-8">
        <header className="text-center mb-8">
          <div className="inline-flex items-center gap-3 bg-gradient-to-r from-amber-100 to-yellow-100 px-6 py-3 rounded-2xl mb-4">
            <Sparkles className="w-6 h-6 text-amber-500" />
            <span className="text-3xl font-bold text-amber-600">{totalButterflies}</span>
            <span className="text-amber-600">/ 520</span>
          </div>
          <h1 className="text-2xl font-bold text-gray-800 mb-1">My Folder</h1>
          <p className="text-gray-500">Your collection of Code Butterflies</p>
        </header>

        {collections.length === 0 ? (
          <div className="text-center py-16">
            <Folder className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <h2 className="text-xl font-medium text-gray-600 mb-2">
              No butterflies yet
            </h2>
            <p className="text-gray-500 mb-6">
              Start learning to collect your first Code Butterfly!
            </p>
            <button
              onClick={() => navigate('/home')}
              className="px-6 py-3 bg-teal-500 text-white rounded-xl font-medium hover:bg-teal-600 transition-colors"
            >
              Start Learning
            </button>
          </div>
        ) : (
          <>
            <div className="flex justify-end mb-4">
              <div className="flex rounded-lg bg-gray-100 p-1">
                <button
                  onClick={() => setViewMode('grid')}
                  className={`p-2 rounded-md transition-colors ${
                    viewMode === 'grid' ? 'bg-white shadow-sm' : 'text-gray-500'
                  }`}
                >
                  <Grid3X3 size={18} />
                </button>
                <button
                  onClick={() => setViewMode('list')}
                  className={`p-2 rounded-md transition-colors ${
                    viewMode === 'list' ? 'bg-white shadow-sm' : 'text-gray-500'
                  }`}
                >
                  <List size={18} />
                </button>
              </div>
            </div>

            <div className="space-y-4">
              {collections.map(({ chapter, terms }) => (
                <div
                  key={chapter.id}
                  className="bg-white/70 backdrop-blur-sm rounded-2xl border border-gray-200/50 overflow-hidden"
                >
                  <button
                    onClick={() => setExpandedChapter(
                      expandedChapter === chapter.id ? null : chapter.id
                    )}
                    className="w-full flex items-center justify-between p-4 hover:bg-gray-50/50 transition-colors"
                  >
                    <div className="flex items-center gap-3">
                      <div className="w-10 h-10 bg-gradient-to-br from-teal-100 to-emerald-100 rounded-xl flex items-center justify-center">
                        <span className="text-teal-600 font-bold">
                          {chapter.id === 17 ? 'EP' : chapter.id}
                        </span>
                      </div>
                      <div className="text-left">
                        <h3 className="font-medium text-gray-800">{chapter.title}</h3>
                        <p className="text-sm text-gray-500">
                          {terms.length} / {chapter.term_count} collected
                        </p>
                      </div>
                    </div>

                    <div className="flex items-center gap-3">
                      <div className="flex -space-x-1">
                        {terms.slice(0, 3).map((_, i) => (
                          <div
                            key={i}
                            className="w-6 h-6 rounded-full bg-gradient-to-br from-amber-300 to-yellow-400 border-2 border-white flex items-center justify-center"
                          >
                            <span className="text-xs">🦋</span>
                          </div>
                        ))}
                        {terms.length > 3 && (
                          <div className="w-6 h-6 rounded-full bg-gray-200 border-2 border-white flex items-center justify-center">
                            <span className="text-xs text-gray-600">+{terms.length - 3}</span>
                          </div>
                        )}
                      </div>
                      <ChevronRight
                        size={20}
                        className={`text-gray-400 transition-transform ${
                          expandedChapter === chapter.id ? 'rotate-90' : ''
                        }`}
                      />
                    </div>
                  </button>

                  {expandedChapter === chapter.id && (
                    <div className="border-t border-gray-100 p-4">
                      {viewMode === 'grid' ? (
                        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
                          {terms.map(term => (
                            <div
                              key={term.id}
                              className="bg-gradient-to-br from-amber-50 to-yellow-50 rounded-xl p-3 border border-amber-100"
                            >
                              <div className="text-center mb-2">
                                <span className="text-2xl">🦋</span>
                              </div>
                              <p className="font-medium text-gray-800 text-sm truncate text-center">
                                {term.term}
                              </p>
                              <p className="text-xs text-gray-500 truncate text-center">
                                {term.term_ja}
                              </p>
                            </div>
                          ))}
                        </div>
                      ) : (
                        <div className="space-y-2">
                          {terms.map(term => (
                            <div
                              key={term.id}
                              className="flex items-center gap-3 p-3 bg-gray-50 rounded-xl"
                            >
                              <span className="text-xl">🦋</span>
                              <div className="flex-1 min-w-0">
                                <p className="font-medium text-gray-800 truncate">
                                  {term.term}
                                </p>
                                <p className="text-sm text-gray-500 truncate">
                                  {term.term_ja} - {term.one_liner}
                                </p>
                              </div>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  )}
                </div>
              ))}
            </div>

            <div className="mt-8 text-center">
              <div className="inline-flex flex-col items-center gap-2 bg-gray-50 rounded-2xl p-6">
                <div className="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-teal-400 to-emerald-500 rounded-full transition-all duration-500"
                    style={{ width: `${(totalButterflies / 520) * 100}%` }}
                  />
                </div>
                <p className="text-sm text-gray-600">
                  {Math.round((totalButterflies / 520) * 100)}% complete
                </p>
                {totalButterflies >= 500 && (
                  <p className="text-amber-600 font-medium">
                    Memory Garden unlocked!
                  </p>
                )}
              </div>
            </div>
          </>
        )}
      </div>
    </Layout>
  );
}
