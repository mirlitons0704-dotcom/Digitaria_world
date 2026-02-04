import { useState, useEffect } from 'react';
import { getCharacters, getCharacter } from '../lib/api';
import type { Character } from '../lib/database.types';

export function useCharacters() {
  const [characters, setCharacters] = useState<Character[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    getCharacters()
      .then(setCharacters)
      .catch(setError)
      .finally(() => setLoading(false));
  }, []);

  return { characters, loading, error };
}

export function useCharacter(id: string | null) {
  const [character, setCharacter] = useState<Character | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (id === null) {
      setLoading(false);
      return;
    }

    setLoading(true);
    getCharacter(id)
      .then(setCharacter)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [id]);

  return { character, loading, error };
}
