import { useState, useEffect, useCallback } from 'react';
import { getStoryScenes } from '../lib/api';
import type { StoryScene } from '../lib/database.types';

export function useStoryScenes(chapterId: number | null) {
  const [scenes, setScenes] = useState<StoryScene[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetch = useCallback(() => {
    if (chapterId === null) {
      setScenes([]);
      setLoading(false);
      return;
    }
    setLoading(true);
    setError(null);
    getStoryScenes(chapterId)
      .then(setScenes)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [chapterId]);

  useEffect(() => {
    fetch();
  }, [fetch]);

  return { scenes, loading, error, retry: fetch };
}
