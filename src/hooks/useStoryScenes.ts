import { useQuery } from '@tanstack/react-query';
import { getStoryScenes } from '../lib/api';

export function useStoryScenes(chapterId: number | null) {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['storyScenes', chapterId],
    queryFn: () => getStoryScenes(chapterId!),
    enabled: chapterId !== null,
  });

  return {
    scenes: data ?? [],
    loading: isLoading,
    error: error as Error | null,
    retry: refetch,
  };
}
