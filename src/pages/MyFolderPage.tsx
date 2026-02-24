import { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAuth } from '../contexts/AuthContext';
import { useChapters } from '../hooks/useChapters';
import { Layout } from '../components/Layout';
import { getUserCollectedTerms, getTermsByIds } from '../lib/api';
import { ASSETS, TOTAL_TERMS } from '../lib/constants';
import { Term, Chapter } from '../lib/database.types';
import {
  Loader2,
  Folder,
  Sparkles,
  ChevronRight,
  BookOpen,
  Cog,
  Lightbulb,
  AlertTriangle,
  Clock,
  X,
  ArrowRight,
} from 'lucide-react';

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

interface CollectedTerm extends Term {
  collected_at: string;
}

interface ChapterCollection {
  chapter: Chapter;
  terms: CollectedTerm[];
}

// ---------------------------------------------------------------------------
// Difficulty badge colours
// ---------------------------------------------------------------------------

const DIFF_COLORS: Record<number, { bg: string; border: string; text: string }> = {
  1: {
    bg: 'from-emerald-50 to-teal-50',
    border: 'border-emerald-200/60',
    text: 'text-emerald-600',
  },
  2: { bg: 'from-blue-50 to-sky-50', border: 'border-blue-200/60', text: 'text-blue-600' },
  3: { bg: 'from-violet-50 to-purple-50', border: 'border-violet-200/60', text: 'text-violet-600' },
};

function diffColor(d: number) {
  return DIFF_COLORS[d] || DIFF_COLORS[1];
}

// ---------------------------------------------------------------------------
// Sub-components
// ---------------------------------------------------------------------------

/** Expanded term detail panel (mini version of InlineTermCard) */
function TermDetail({ term, onClose }: { term: Term; onClose: () => void }) {
  const { t } = useTranslation();
  return (
    <div className="mt-2 rounded-xl bg-white/90 backdrop-blur-sm border border-gray-200/60 shadow-sm overflow-hidden animate-[inline-term-card-enter_0.2s_ease-out]">
      <div className="px-4 pt-3 pb-2">
        <div className="flex items-start justify-between mb-2">
          <div>
            <h4 className="font-bold text-gray-800">{term.term}</h4>
            <p className="text-xs text-teal-600 font-medium">{term.one_liner}</p>
          </div>
          <button
            onClick={onClose}
            className="p-1 rounded-full text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-colors"
          >
            <X size={14} />
          </button>
        </div>

        <div className="flex items-start gap-2 mb-3">
          <BookOpen size={13} className="text-gray-400 mt-0.5 shrink-0" />
          <p className="text-sm text-gray-600 leading-relaxed">{term.definition}</p>
        </div>

        <div className="space-y-2">
          {term.mechanism && (
            <div className="bg-gray-50 rounded-lg p-2.5">
              <div className="flex items-start gap-2">
                <Cog size={13} className="text-gray-400 mt-0.5 shrink-0" />
                <div>
                  <p className="text-[10px] text-gray-500 font-medium mb-0.5">
                    {t('termCard.howItWorks')}
                  </p>
                  <p className="text-xs text-gray-600 leading-relaxed">{term.mechanism}</p>
                </div>
              </div>
            </div>
          )}
          {term.analogy && (
            <div className="bg-gray-50 rounded-lg p-2.5">
              <div className="flex items-start gap-2">
                <Lightbulb size={13} className="text-amber-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-[10px] text-amber-600 font-medium mb-0.5">
                    {t('termCard.analogy')}
                  </p>
                  <p className="text-xs text-gray-600 leading-relaxed">{term.analogy}</p>
                </div>
              </div>
            </div>
          )}
          {term.pitfall && (
            <div className="bg-gray-50 rounded-lg p-2.5">
              <div className="flex items-start gap-2">
                <AlertTriangle size={13} className="text-rose-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-[10px] text-rose-600 font-medium mb-0.5">
                    {t('termCard.watchOut')}
                  </p>
                  <p className="text-xs text-gray-600 leading-relaxed">{term.pitfall}</p>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

/** Butterfly card (grid mode) */
function ButterflyCard({
  term,
  isExpanded,
  onToggle,
}: {
  term: CollectedTerm;
  isExpanded: boolean;
  onToggle: () => void;
}) {
  const dc = diffColor(term.difficulty);
  return (
    <div>
      <button
        onClick={onToggle}
        className={`w-full text-left bg-gradient-to-br ${dc.bg} rounded-xl p-3 border ${dc.border} hover:shadow-md transition-all ${
          isExpanded ? 'ring-2 ring-teal-400/40' : ''
        }`}
      >
        <div className="flex items-center justify-between mb-1">
          <span className="text-lg">🦋</span>
          <span className={`text-[10px] font-medium ${dc.text}`}>
            {'★'.repeat(term.difficulty)}
          </span>
        </div>
        <p className="font-medium text-gray-800 text-sm truncate">{term.term}</p>
        <p className="text-xs text-gray-500 truncate">{term.term_ja}</p>
      </button>
      {isExpanded && <TermDetail term={term} onClose={onToggle} />}
    </div>
  );
}

/** Butterfly row (list mode) */
function ButterflyRow({
  term,
  isExpanded,
  onToggle,
}: {
  term: CollectedTerm;
  isExpanded: boolean;
  onToggle: () => void;
}) {
  const dc = diffColor(term.difficulty);
  return (
    <div>
      <button
        onClick={onToggle}
        className={`w-full flex items-center gap-3 p-3 rounded-xl transition-all hover:bg-gray-50 ${
          isExpanded ? 'bg-gray-50 ring-1 ring-teal-400/30' : ''
        }`}
      >
        <span className="text-xl shrink-0">🦋</span>
        <div className="flex-1 min-w-0 text-left">
          <p className="font-medium text-gray-800 truncate">{term.term}</p>
          <p className="text-sm text-gray-500 truncate">{term.one_liner}</p>
        </div>
        <span className={`text-xs font-medium ${dc.text} shrink-0`}>
          {'★'.repeat(term.difficulty)}
        </span>
      </button>
      {isExpanded && <TermDetail term={term} onClose={onToggle} />}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Main page
// ---------------------------------------------------------------------------

export function MyFolderPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const { user } = useAuth();
  const { chapters } = useChapters();
  const [collections, setCollections] = useState<ChapterCollection[]>([]);
  const [allTerms, setAllTerms] = useState<CollectedTerm[]>([]);
  const [loading, setLoading] = useState(true);
  const [fetchError, setFetchError] = useState<string | null>(null);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  const [expandedChapter, setExpandedChapter] = useState<number | null>(null);
  const [expandedTermId, setExpandedTermId] = useState<string | null>(null);
  const [totalButterflies, setTotalButterflies] = useState(0);

  // Recently collected (last 5)
  const recentTerms = useMemo(
    () =>
      [...allTerms]
        .sort((a, b) => new Date(b.collected_at).getTime() - new Date(a.collected_at).getTime())
        .slice(0, 5),
    [allTerms]
  );

  const toggleTerm = (termId: string) => {
    setExpandedTermId((prev) => (prev === termId ? null : termId));
  };

  useEffect(() => {
    if (!user) return;

    const userId = user.id;

    async function fetchCollections() {
      setLoading(true);

      try {
        const progress = await getUserCollectedTerms(userId);

        if (!progress || progress.length === 0) {
          setCollections([]);
          setAllTerms([]);
          setTotalButterflies(0);
          setLoading(false);
          return;
        }

        const termIds = progress.map((p) => p.term_id);
        const progressMap = new Map(progress.map((p) => [p.term_id, p.created_at]));

        const terms = await getTermsByIds(termIds);

        if (!terms || terms.length === 0) {
          setCollections([]);
          setAllTerms([]);
          setLoading(false);
          return;
        }

        const collectedTerms: CollectedTerm[] = terms.map((term) => ({
          ...term,
          collected_at: progressMap.get(term.id) || new Date().toISOString(),
        }));

        const chapterMap = new Map<number, CollectedTerm[]>();
        collectedTerms.forEach((term) => {
          const existing = chapterMap.get(term.chapter_id) || [];
          existing.push(term);
          chapterMap.set(term.chapter_id, existing);
        });

        const result: ChapterCollection[] = chapters
          .filter((chapter) => chapterMap.has(chapter.id))
          .map((chapter) => ({
            chapter,
            terms: chapterMap.get(chapter.id)!.sort((a, b) => a.order_index - b.order_index),
          }));

        setCollections(result);
        setAllTerms(collectedTerms);
        setTotalButterflies(collectedTerms.length);
      } catch (error) {
        console.error('Failed to fetch collections:', error);
        setFetchError('Failed to load your collection. Please try again.');
        setCollections([]);
      } finally {
        setLoading(false);
      }
    }

    fetchCollections();
  }, [user, chapters]);

  const pct = TOTAL_TERMS > 0 ? Math.round((totalButterflies / TOTAL_TERMS) * 100) : 0;

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

  if (fetchError) {
    return (
      <Layout>
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
          <p className="text-red-500">{fetchError}</p>
          <button
            onClick={() => window.location.reload()}
            className="text-teal-500 hover:text-teal-600"
          >
            {t('myFolder.reload')}
          </button>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="max-w-4xl mx-auto px-4 py-8">
        {/* ── Header ── */}
        <header className="mb-10">
          <div className="flex items-center justify-center gap-4 md:gap-6">
            <div className="w-20 md:w-24 shrink-0">
              <video
                className="w-full h-auto rounded-lg"
                src={ASSETS.bitKunProud}
                autoPlay
                loop
                muted
                playsInline
              />
            </div>

            <div className="text-center flex-1">
              <h1 className="text-2xl md:text-3xl text-gray-800 font-display mb-1">
                {t('myFolder.title')}
              </h1>
              <p className="text-gray-500 text-sm md:text-base mb-4">{t('myFolder.subtitle')}</p>

              {/* Badge + progress */}
              <div className="inline-flex flex-col items-center gap-2">
                <div className="inline-flex items-center gap-2 bg-gradient-to-r from-amber-100 to-yellow-100 px-5 py-2 rounded-full">
                  <Sparkles className="w-5 h-5 text-amber-500" />
                  <span className="text-2xl font-bold text-amber-600">{totalButterflies}</span>
                  <span className="text-sm text-amber-600/70">/ {TOTAL_TERMS}</span>
                </div>
                <div className="w-48 h-1.5 bg-gray-200 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-teal-400 to-emerald-500 rounded-full transition-all duration-500"
                    style={{ width: `${pct}%` }}
                  />
                </div>
                <p className="text-xs text-gray-500">
                  {pct}% {t('myFolder.complete')}
                </p>
              </div>
            </div>

            <div className="w-20 md:w-24 shrink-0">
              <video
                className="w-full h-auto rounded-lg"
                src={ASSETS.byteSanProud}
                autoPlay
                loop
                muted
                playsInline
              />
            </div>
          </div>
        </header>

        {collections.length === 0 ? (
          /* ── Empty state ── */
          <div className="text-center py-16">
            <Folder className="w-16 h-16 text-gray-300 mx-auto mb-4" />
            <h2 className="text-xl font-medium text-gray-600 mb-2">{t('myFolder.emptyTitle')}</h2>
            <p className="text-gray-500 mb-6">{t('myFolder.emptyMessage')}</p>
            <button
              onClick={() => navigate('/home')}
              className="inline-flex items-center gap-2 px-6 py-3 bg-teal-500 text-white rounded-xl font-medium hover:bg-teal-600 transition-colors"
            >
              <ArrowRight size={16} />
              {t('myFolder.startLearning')}
            </button>
          </div>
        ) : (
          <>
            {/* ── Recently collected ── */}
            {recentTerms.length > 0 && (
              <section className="mb-8">
                <div className="flex items-center gap-2 mb-3">
                  <Clock size={16} className="text-gray-400" />
                  <h2 className="text-sm font-semibold text-gray-600">
                    {t('myFolder.recentlyCollected')}
                  </h2>
                </div>
                <div className="flex gap-3 overflow-x-auto pb-2 -mx-1 px-1 scrollbar-hide">
                  {recentTerms.map((term) => {
                    const dc = diffColor(term.difficulty);
                    return (
                      <button
                        key={term.id}
                        onClick={() => toggleTerm(term.id)}
                        className={`shrink-0 w-32 bg-gradient-to-br ${dc.bg} rounded-xl p-3 border ${dc.border} hover:shadow-md transition-all text-left`}
                      >
                        <span className="text-lg">🦋</span>
                        <p className="font-medium text-gray-800 text-sm truncate mt-1">
                          {term.term}
                        </p>
                        <p className="text-[10px] text-gray-500 truncate">{term.term_ja}</p>
                      </button>
                    );
                  })}
                </div>
                {/* Expanded detail for recent term */}
                {expandedTermId && recentTerms.some((t) => t.id === expandedTermId) && (
                  <TermDetail
                    term={recentTerms.find((t) => t.id === expandedTermId)!}
                    onClose={() => setExpandedTermId(null)}
                  />
                )}
              </section>
            )}

            {/* ── View toggle ── */}
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-sm font-semibold text-gray-600">{t('myFolder.byChapter')}</h2>
              <div className="flex rounded-lg bg-white/70 backdrop-blur-sm border border-gray-200/50 p-1">
                <button
                  onClick={() => setViewMode('grid')}
                  className={`px-3 py-1.5 rounded-md text-xs font-medium transition-colors ${
                    viewMode === 'grid'
                      ? 'bg-teal-500 text-white shadow-sm'
                      : 'text-gray-500 hover:text-gray-700'
                  }`}
                >
                  {t('myFolder.grid')}
                </button>
                <button
                  onClick={() => setViewMode('list')}
                  className={`px-3 py-1.5 rounded-md text-xs font-medium transition-colors ${
                    viewMode === 'list'
                      ? 'bg-teal-500 text-white shadow-sm'
                      : 'text-gray-500 hover:text-gray-700'
                  }`}
                >
                  {t('myFolder.list')}
                </button>
              </div>
            </div>

            {/* ── Chapter accordion ── */}
            <div className="space-y-3">
              {collections.map(({ chapter, terms }) => {
                const chapterPct =
                  chapter.term_count > 0
                    ? Math.round((terms.length / chapter.term_count) * 100)
                    : 0;
                const isComplete = terms.length === chapter.term_count;

                return (
                  <div
                    key={chapter.id}
                    className="bg-white/70 backdrop-blur-sm rounded-2xl border border-gray-200/50 overflow-hidden"
                  >
                    <button
                      onClick={() =>
                        setExpandedChapter(expandedChapter === chapter.id ? null : chapter.id)
                      }
                      aria-expanded={expandedChapter === chapter.id}
                      className="w-full flex items-center justify-between p-4 hover:bg-gray-50/50 transition-colors"
                    >
                      <div className="flex items-center gap-3 flex-1 min-w-0">
                        <div
                          className={`w-10 h-10 rounded-xl flex items-center justify-center shrink-0 ${
                            isComplete
                              ? 'bg-gradient-to-br from-amber-200 to-yellow-300'
                              : 'bg-gradient-to-br from-teal-100 to-emerald-100'
                          }`}
                        >
                          <span
                            className={`font-bold text-sm ${
                              isComplete ? 'text-amber-700' : 'text-teal-600'
                            }`}
                          >
                            {chapter.id === 17 ? 'EP' : chapter.id}
                          </span>
                        </div>
                        <div className="text-left flex-1 min-w-0">
                          <h3 className="font-medium text-gray-800 truncate">{chapter.title}</h3>
                          <div className="flex items-center gap-2 mt-1">
                            <div className="flex-1 h-1.5 bg-gray-100 rounded-full overflow-hidden max-w-[120px]">
                              <div
                                className={`h-full rounded-full transition-all duration-500 ${
                                  isComplete
                                    ? 'bg-gradient-to-r from-amber-400 to-yellow-400'
                                    : 'bg-gradient-to-r from-teal-400 to-emerald-500'
                                }`}
                                style={{ width: `${chapterPct}%` }}
                              />
                            </div>
                            <span className="text-xs text-gray-500 shrink-0">
                              {terms.length}/{chapter.term_count}
                            </span>
                            {isComplete && <span className="text-xs">✨</span>}
                          </div>
                        </div>
                      </div>

                      <ChevronRight
                        size={20}
                        className={`text-gray-400 transition-transform shrink-0 ml-2 ${
                          expandedChapter === chapter.id ? 'rotate-90' : ''
                        }`}
                      />
                    </button>

                    {expandedChapter === chapter.id && (
                      <div className="border-t border-gray-100 p-4">
                        {viewMode === 'grid' ? (
                          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
                            {terms.map((term) => (
                              <ButterflyCard
                                key={term.id}
                                term={term}
                                isExpanded={expandedTermId === term.id}
                                onToggle={() => toggleTerm(term.id)}
                              />
                            ))}
                          </div>
                        ) : (
                          <div className="space-y-1">
                            {terms.map((term) => (
                              <ButterflyRow
                                key={term.id}
                                term={term}
                                isExpanded={expandedTermId === term.id}
                                onToggle={() => toggleTerm(term.id)}
                              />
                            ))}
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>

            {totalButterflies >= 500 && (
              <div className="mt-6 text-center">
                <p className="text-amber-600 font-medium text-sm">
                  {t('myFolder.memoryGardenUnlocked')}
                </p>
              </div>
            )}
          </>
        )}
      </div>
    </Layout>
  );
}
