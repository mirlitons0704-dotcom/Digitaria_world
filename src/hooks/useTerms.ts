import { useState, useEffect } from 'react';
import { getTermsByChapter, getTerm, searchTerms, getRandomTermsForQuiz } from '../lib/api';
import type { Term } from '../lib/database.types';

export function useTermsByChapter(chapterId: number | null) {
  const [terms, setTerms] = useState<Term[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (chapterId === null) {
      setTerms([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    getTermsByChapter(chapterId)
      .then(setTerms)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [chapterId]);

  return { terms, loading, error };
}

export function useTerm(id: string | null) {
  const [term, setTerm] = useState<Term | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (id === null) {
      setLoading(false);
      return;
    }

    setLoading(true);
    getTerm(id)
      .then(setTerm)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  return { term, loading, error };
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

  const refresh = () => {
    setLoading(true);
    getRandomTermsForQuiz(chapterId, count)
      .then(setTerms)
      .catch(setError)
      .finally(() => setLoading(false));
  };

  useEffect(() => {
    refresh();
  }, [chapterId, count]);

  return { terms, loading, error, refresh };
}
