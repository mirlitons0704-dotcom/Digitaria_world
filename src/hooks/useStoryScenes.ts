import { useState, useEffect } from 'react';
import { getStoryScenes } from '../lib/api';
import type { StoryScene } from '../lib/database.types';

export function useStoryScenes(chapterId: number | null) {
  const [scenes, setScenes] = useState<StoryScene[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (chapterId === null) {
      setScenes([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    getStoryScenes(chapterId)
      .then(setScenes)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [chapterId]);

  return { scenes, loading, error };
}
