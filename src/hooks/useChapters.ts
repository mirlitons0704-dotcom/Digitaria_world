import { useState, useEffect } from 'react';
import { getChapters, getChapter, getChapterWithGuide } from '../lib/api';
import type { Chapter, Character } from '../lib/database.types';

export function useChapters() {
  const [chapters, setChapters] = useState<Chapter[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    getChapters()
      .then(setChapters)
      .catch(setError)
      .finally(() => setLoading(false));
  }, []);

  return { chapters, loading, error };
}

export function useChapter(id: number | null) {
  const [chapter, setChapter] = useState<Chapter | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (id === null) {
      setLoading(false);
      return;
    }

    setLoading(true);
    getChapter(id)
      .then(setChapter)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  return { chapter, loading, error };
}

export function useChapterWithGuide(id: number | null) {
  const [data, setData] = useState<(Chapter & { guide: Character | null }) | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (id === null) {
      setLoading(false);
      return;
    }

    setLoading(true);
    getChapterWithGuide(id)
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  return { chapter: data, loading, error };
}
