import { useState, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useChapter } from '../hooks/useChapters';
import { useTermsByChapter } from '../hooks/useTerms';
import { useAuth } from '../contexts/AuthContext';
import { Layout } from '../components/Layout';
import { FlashCard } from '../components/FlashCard';
import {
  saveTermProgress,
  saveMultipleTermProgress,
  getUserButterflyCount,
  updateUserButterflyCount
} from '../lib/api';
import { Term } from '../lib/database.types';
import { Loader2, ArrowLeft, Check, X, RotateCcw, Trophy, Sparkles } from 'lucide-react';

export function FlashcardPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const chapterId = id ? parseInt(id, 10) : null;
  const { chapter, loading: chapterLoading } = useChapter(chapterId);
  const { terms, loading: termsLoading } = useTermsByChapter(chapterId);

  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [understood, setUnderstood] = useState<Set<string>>(new Set());
  const [reviewing, setReviewing] = useState<Set<string>>(new Set());
  const [showResults, setShowResults] = useState(false);
  const [saving, setSaving] = useState(false);

  const loading = chapterLoading || termsLoading;
  const currentTerm = terms[currentIndex];
  const isLastCard = currentIndex === terms.length - 1;

  const handleFlip = useCallback(() => {
    setIsFlipped(!isFlipped);
  }, [isFlipped]);

  const handleUnderstood = useCallback(async (term: Term) => {
    const newUnderstood = new Set(understood);
    newUnderstood.add(term.id);
    setUnderstood(newUnderstood);

    reviewing.delete(term.id);
    setReviewing(new Set(reviewing));

    if (user) {
      await saveTermProgress(user.id, term.id, 3, 'butterfly');
    }

    if (isLastCard) {
      setShowResults(true);
    } else {
      setCurrentIndex(currentIndex + 1);
      setIsFlipped(false);
    }
  }, [understood, reviewing, user, isLastCard, currentIndex]);

  const handleReview = useCallback((term: Term) => {
    const newReviewing = new Set(reviewing);
    newReviewing.add(term.id);
    setReviewing(newReviewing);

    if (isLastCard) {
      setShowResults(true);
    } else {
      setCurrentIndex(currentIndex + 1);
      setIsFlipped(false);
    }
  }, [reviewing, isLastCard, currentIndex]);

  const handleRestart = useCallback(() => {
    setCurrentIndex(0);
    setIsFlipped(false);
    setUnderstood(new Set());
    setReviewing(new Set());
    setShowResults(false);
  }, []);

  const handleSaveAndExit = useCallback(async () => {
    if (!user) {
      navigate(`/chapter/${chapterId}`);
      return;
    }

    setSaving(true);

    const termIds = Array.from(understood);
    if (termIds.length > 0) {
      await saveMultipleTermProgress(user.id, termIds, 3, 'butterfly');
    }

    const count = await getUserButterflyCount(user.id);
    await updateUserButterflyCount(user.id, count);

    setSaving(false);
    navigate(`/chapter/${chapterId}`);
  }, [user, understood, chapterId, navigate]);

  if (loading) {
    return (
      <Layout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-500" />
        </div>
      </Layout>
    );
  }

  if (!chapter || terms.length === 0) {
    return (
      <Layout>
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
          <p className="text-gray-500">No terms found</p>
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

  if (showResults) {
    const understoodCount = understood.size;
    const reviewCount = reviewing.size;
    const percentage = Math.round((understoodCount / terms.length) * 100);

    return (
      <Layout>
        <div className="max-w-2xl mx-auto px-4 py-12">
          <div className="bg-white/80 backdrop-blur-sm rounded-3xl p-8 shadow-xl text-center">
            <div className="w-20 h-20 bg-gradient-to-br from-amber-400 to-orange-500 rounded-full flex items-center justify-center mx-auto mb-6">
              <Trophy className="w-10 h-10 text-white" />
            </div>

            <h2 className="text-2xl font-bold text-gray-800 mb-2">
              Session Complete!
            </h2>
            <p className="text-gray-600 mb-8">
              {chapter.title}
            </p>

            <div className="grid grid-cols-2 gap-4 mb-8">
              <div className="bg-gradient-to-br from-teal-50 to-emerald-50 rounded-2xl p-4 border border-teal-100">
                <div className="flex items-center justify-center gap-2 mb-2">
                  <Sparkles className="w-5 h-5 text-teal-500" />
                  <span className="text-3xl font-bold text-teal-600">{understoodCount}</span>
                </div>
                <p className="text-sm text-teal-600">Butterflies Earned</p>
              </div>
              <div className="bg-gradient-to-br from-amber-50 to-orange-50 rounded-2xl p-4 border border-amber-100">
                <div className="flex items-center justify-center gap-2 mb-2">
                  <RotateCcw className="w-5 h-5 text-amber-500" />
                  <span className="text-3xl font-bold text-amber-600">{reviewCount}</span>
                </div>
                <p className="text-sm text-amber-600">To Review</p>
              </div>
            </div>

            <div className="mb-8">
              <div className="flex justify-between text-sm text-gray-500 mb-2">
                <span>Mastery</span>
                <span>{percentage}%</span>
              </div>
              <div className="h-3 bg-gray-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-gradient-to-r from-teal-400 to-emerald-500 rounded-full transition-all duration-1000"
                  style={{ width: `${percentage}%` }}
                />
              </div>
            </div>

            <div className="flex flex-col sm:flex-row gap-3">
              <button
                onClick={handleRestart}
                className="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-gray-100 text-gray-700 rounded-xl font-medium hover:bg-gray-200 transition-colors"
              >
                <RotateCcw size={18} />
                Practice Again
              </button>
              <button
                onClick={handleSaveAndExit}
                disabled={saving}
                className="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-gradient-to-r from-teal-500 to-emerald-500 text-white rounded-xl font-medium hover:from-teal-600 hover:to-emerald-600 transition-all disabled:opacity-50"
              >
                {saving ? (
                  <Loader2 size={18} className="animate-spin" />
                ) : (
                  <Check size={18} />
                )}
                Save & Exit
              </button>
            </div>
          </div>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="max-w-2xl mx-auto px-4 py-6">
        <div className="flex items-center justify-between mb-6">
          <button
            onClick={() => navigate(`/chapter/${chapterId}`)}
            className="flex items-center gap-2 text-gray-500 hover:text-gray-700 transition-colors"
          >
            <ArrowLeft size={18} />
            <span className="hidden sm:inline">Back</span>
          </button>

          <div className="text-center">
            <p className="text-sm text-gray-500">{chapter.title}</p>
            <p className="text-xs text-gray-400">
              {currentIndex + 1} / {terms.length}
            </p>
          </div>

          <div className="flex items-center gap-2 text-sm">
            <span className="text-teal-500 font-medium">{understood.size}</span>
            <Sparkles size={16} className="text-teal-500" />
          </div>
        </div>

        <div className="mb-4">
          <div className="h-1.5 bg-gray-200 rounded-full overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-teal-400 to-emerald-500 rounded-full transition-all duration-300"
              style={{ width: `${((currentIndex + 1) / terms.length) * 100}%` }}
            />
          </div>
        </div>

        <FlashCard
          term={currentTerm}
          isFlipped={isFlipped}
          onFlip={handleFlip}
        />

        <div className="flex items-center justify-center gap-4 mt-6">
          {isFlipped ? (
            <>
              <button
                onClick={() => handleReview(currentTerm)}
                className="flex items-center gap-2 px-6 py-3 bg-amber-100 text-amber-700 rounded-xl font-medium hover:bg-amber-200 transition-colors"
              >
                <X size={20} />
                <span>Review Later</span>
              </button>
              <button
                onClick={() => handleUnderstood(currentTerm)}
                className="flex items-center gap-2 px-6 py-3 bg-teal-500 text-white rounded-xl font-medium hover:bg-teal-600 transition-colors"
              >
                <Check size={20} />
                <span>Got it!</span>
              </button>
            </>
          ) : (
            <button
              onClick={handleFlip}
              className="px-8 py-3 bg-gray-100 text-gray-700 rounded-xl font-medium hover:bg-gray-200 transition-colors"
            >
              Tap to reveal
            </button>
          )}
        </div>
      </div>
    </Layout>
  );
}
