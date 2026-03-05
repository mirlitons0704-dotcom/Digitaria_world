import { useState, useEffect, useCallback } from 'react';
import { saveTermProgress, getUserCollectedTerms } from '../lib/api';

interface UseTermCollectionReturn {
  collectedTermIds: Set<string>;
  savingTermId: string | null;
  saveError: string | null;
  handleGotIt: (termId: string) => Promise<void>;
}

export function useTermCollection(userId: string | undefined): UseTermCollectionReturn {
  const [collectedTermIds, setCollectedTermIds] = useState<Set<string>>(new Set());
  const [savingTermId, setSavingTermId] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);

  // Auto-dismiss save error after 3 seconds
  useEffect(() => {
    if (!saveError) return;
    const timer = setTimeout(() => setSaveError(null), 3000);
    return () => clearTimeout(timer);
  }, [saveError]);

  // Fetch collected terms on mount
  useEffect(() => {
    if (!userId) return;
    getUserCollectedTerms(userId)
      .then((progress) => {
        setCollectedTermIds(new Set(progress.map((p) => p.term_id)));
      })
      .catch(() => {
        // Non-critical: collected status will just not show
      });
  }, [userId]);

  const handleGotIt = useCallback(
    async (termId: string) => {
      if (!userId) return;
      setSavingTermId(termId);
      setSaveError(null);
      try {
        await saveTermProgress(userId, termId, 3, 'butterfly');
        setCollectedTermIds((prev) => new Set([...prev, termId]));
      } catch {
        setSaveError('Failed to save progress. Please try again.');
      } finally {
        setSavingTermId(null);
      }
    },
    [userId]
  );

  return { collectedTermIds, savingTermId, saveError, handleGotIt };
}
