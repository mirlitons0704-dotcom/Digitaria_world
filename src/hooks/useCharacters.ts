import { useQuery } from '@tanstack/react-query';
import { getCharacters, getCharacter } from '../lib/api';
import type { Character } from '../lib/database.types';

export function useCharacters() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['characters'],
    queryFn: getCharacters,
  });

  return {
    characters: data ?? ([] as Character[]),
    loading: isLoading,
    error: error as Error | null,
  };
}

export function useCharacter(id: string | null) {
  const { data, isLoading, error } = useQuery({
    queryKey: ['character', id],
    queryFn: () => getCharacter(id!),
    enabled: id !== null,
  });

  return {
    character: data ?? null,
    loading: isLoading,
    error: error as Error | null,
  };
}
