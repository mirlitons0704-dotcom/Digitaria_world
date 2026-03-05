import { useState, useEffect } from 'react';
import { useQuery } from '@tanstack/react-query';
import { getTermsByChapter, getTerm, searchTerms, getRandomTermsForQuiz } from '../lib/api';

export function useTermsByChapter(chapterId: number | null) {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['termsByChapter', chapterId],
    queryFn: () => getTermsByChapter(chapterId!),
    enabled: chapterId !== null,
  });

  return {
    terms: data ?? [],
    loading: isLoading,
    error: error as Error | null,
    retry: refetch,
  };
}

export function useTerm(id: string | null) {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['term', id],
    queryFn: () => getTerm(id!),
    enabled: id !== null,
  });

  return {
    term: data ?? null,
    loading: isLoading,
    error: error as Error | null,
    retry: refetch,
  };
}

export function useSearchTerms(query: string) {
  const [debouncedQuery, setDebouncedQuery] = useState('');

  useEffect(() => {
    if (!query.trim()) {
      setDebouncedQuery('');
      return;
    }
    const timeoutId = setTimeout(() => setDebouncedQuery(query), 300);
    return () => clearTimeout(timeoutId);
  }, [query]);

  const { data, isLoading, error } = useQuery({
    queryKey: ['searchTerms', debouncedQuery],
    queryFn: () => searchTerms(debouncedQuery),
    enabled: debouncedQuery.trim().length > 0,
    staleTime: 30 * 1000,
  });

  return {
    results: debouncedQuery.trim() ? (data ?? []) : [],
    loading: isLoading && debouncedQuery.trim().length > 0,
    error: error as Error | null,
  };
}

export function useQuizTerms(chapterId: number | null, count: number = 10) {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['quizTerms', chapterId, count],
    queryFn: () => getRandomTermsForQuiz(chapterId, count),
    staleTime: 0,
  });

  return {
    terms: data ?? [],
    loading: isLoading,
    error: error as Error | null,
    refresh: refetch,
  };
}
