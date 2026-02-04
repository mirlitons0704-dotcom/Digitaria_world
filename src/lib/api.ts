import { supabase } from './supabase';
import type { Chapter, Term, Character, StoryScene } from './database.types';

export async function getChapters(): Promise<Chapter[]> {
  const { data, error } = await supabase
    .from('chapters')
    .select('*')
    .order('id');

  if (error) throw error;
  return data || [];
}

export async function getChapter(id: number): Promise<Chapter | null> {
  const { data, error } = await supabase
    .from('chapters')
    .select('*')
    .eq('id', id)
    .maybeSingle();

  if (error) throw error;
  return data;
}

export async function getChapterWithGuide(id: number): Promise<(Chapter & { guide: Character | null }) | null> {
  const { data, error } = await supabase
    .from('chapters')
    .select(`
      *,
      guide:characters!chapters_guide_id_fkey(*)
    `)
    .eq('id', id)
    .maybeSingle();

  if (error) throw error;
  return data;
}

export async function getTermsByChapter(chapterId: number): Promise<Term[]> {
  const { data, error } = await supabase
    .from('terms')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('order_index');

  if (error) throw error;
  return data || [];
}

export async function getTerm(id: string): Promise<Term | null> {
  const { data, error } = await supabase
    .from('terms')
    .select('*')
    .eq('id', id)
    .maybeSingle();

  if (error) throw error;
  return data;
}

export async function searchTerms(query: string): Promise<Term[]> {
  const { data, error } = await supabase
    .from('terms')
    .select('*')
    .or(`term.ilike.%${query}%,term_ja.ilike.%${query}%,one_liner.ilike.%${query}%`)
    .limit(20);

  if (error) throw error;
  return data || [];
}

export async function getCharacter(id: string): Promise<Character | null> {
  const { data, error } = await supabase
    .from('characters')
    .select('*')
    .eq('id', id)
    .maybeSingle();

  if (error) throw error;
  return data;
}

export async function getCharacters(): Promise<Character[]> {
  const { data, error } = await supabase
    .from('characters')
    .select('*')
    .order('chapter_appearance');

  if (error) throw error;
  return data || [];
}

export async function getStoryScenes(chapterId: number): Promise<StoryScene[]> {
  const { data, error } = await supabase
    .from('story_scenes')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('scene_number');

  if (error) throw error;
  return data || [];
}

export async function getTotalTermCount(): Promise<number> {
  const { count, error } = await supabase
    .from('terms')
    .select('*', { count: 'exact', head: true });

  if (error) throw error;
  return count || 0;
}

export async function getRandomTermsForQuiz(
  chapterId: number | null,
  count: number = 10
): Promise<Term[]> {
  let query = supabase.from('terms').select('*');

  if (chapterId) {
    query = query.eq('chapter_id', chapterId);
  }

  const { data, error } = await query;

  if (error) throw error;

  const terms = data || [];
  const shuffled = terms.sort(() => Math.random() - 0.5);
  return shuffled.slice(0, count);
}
