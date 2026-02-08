import { useState, useEffect, useCallback } from 'react';
import { getChapters, getChapter, getChapterWithGuide } from '../lib/api';
import type { Chapter, Character } from '../lib/database.types';

export function useChapters() {
  const [chapters, setChapters] = useState<Chapter[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetch = useCallback(() => {
    setLoading(true);
    setError(null);
    getChapters()
      .then(setChapters)
      .catch(setError)
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    fetch();
  }, [fetch]);

  return { chapters, loading, error, retry: fetch };
}

export function useChapter(id: number | null) {
  const [chapter, setChapter] = useState<Chapter | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetch = useCallback(() => {
    if (id === null) {
      setLoading(false);
      return;
    }
    setLoading(true);
    setError(null);
    getChapter(id)
      .then(setChapter)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  useEffect(() => {
    fetch();
  }, [fetch]);

  return { chapter, loading, error, retry: fetch };
}

export function useChapterWithGuide(id: number | null) {
  const [data, setData] = useState<(Chapter & { guide: Character | null }) | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetch = useCallback(() => {
    if (id === null) {
      setLoading(false);
      return;
    }
    setLoading(true);
    setError(null);
    getChapterWithGuide(id)
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  useEffect(() => {
    fetch();
  }, [fetch]);

  return { chapter: data, loading, error, retry: fetch };
}
