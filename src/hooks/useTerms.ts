import { useState, useEffect, useCallback } from 'react';
import { getTermsByChapter, getTerm, searchTerms, getRandomTermsForQuiz } from '../lib/api';
import type { Term } from '../lib/database.types';

export function useTermsByChapter(chapterId: number | null) {
  const [terms, setTerms] = useState<Term[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetch = useCallback(() => {
    if (chapterId === null) {
      setTerms([]);
      setLoading(false);
      return;
    }
    setLoading(true);
    setError(null);
    getTermsByChapter(chapterId)
      .then(setTerms)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [chapterId]);

  useEffect(() => {
    fetch();
  }, [fetch]);

  return { terms, loading, error, retry: fetch };
}

export function useTerm(id: string | null) {
  const [term, setTerm] = useState<Term | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetch = useCallback(() => {
    if (id === null) {
      setLoading(false);
      return;
    }
    setLoading(true);
    setError(null);
    getTerm(id)
      .then(setTerm)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  useEffect(() => {
    fetch();
  }, [fetch]);

  return { term, loading, error, retry: fetch };
}

export function useSearchTerms(query: string) {
  const [results, setResults] = useState<Term[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      return;
    }

    setLoading(true);
    setError(null);
    const timeoutId = setTimeout(() => {
      searchTerms(query)
        .then(setResults)
        .catch(setError)
        .finally(() => setLoading(false));
    }, 300);

    return () => clearTimeout(timeoutId);
  }, [query]);

  return { results, loading, error };
}

export function useQuizTerms(chapterId: number | null, count: number = 10) {
  const [terms, setTerms] = useState<Term[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetchQuiz = useCallback(() => {
    setLoading(true);
    getRandomTermsForQuiz(chapterId, count)
      .then(setTerms)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [chapterId, count]);

  useEffect(() => {
    fetchQuiz();
  }, [fetchQuiz]);

  return { terms, loading, error, refresh: fetchQuiz };
}
