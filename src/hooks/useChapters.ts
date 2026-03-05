import { useQuery } from '@tanstack/react-query';
import { getChapters, getChapter, getChapterWithGuide } from '../lib/api';
import type { Chapter, Character } from '../lib/database.types';

export function useChapters() {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['chapters'],
    queryFn: getChapters,
  });

  return {
    chapters: data ?? [],
    loading: isLoading,
    error: error as Error | null,
    retry: refetch,
  };
}

export function useChapter(id: number | null) {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['chapter', id],
    queryFn: () => getChapter(id!),
    enabled: id !== null,
  });

  return {
    chapter: data ?? null,
    loading: isLoading,
    error: error as Error | null,
    retry: refetch,
  };
}

export function useChapterWithGuide(id: number | null) {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['chapterWithGuide', id],
    queryFn: () => getChapterWithGuide(id!),
    enabled: id !== null,
  });

  return {
    chapter: (data ?? null) as (Chapter & { guide: Character | null }) | null,
    loading: isLoading,
    error: error as Error | null,
    retry: refetch,
  };
}
