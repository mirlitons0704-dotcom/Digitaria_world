import { supabase } from './supabase';
import type { Chapter, Term, Character, StoryScene } from './database.types';

export async function getChapters(): Promise<Chapter[]> {
  const { data, error } = await supabase.from('chapters').select('*').order('id');

  if (error) throw error;
  return data || [];
}

export async function getChapter(id: number): Promise<Chapter | null> {
  const { data, error } = await supabase.from('chapters').select('*').eq('id', id).maybeSingle();

  if (error) throw error;
  return data;
}

export async function getChapterWithGuide(
  id: number
): Promise<(Chapter & { guide: Character | null }) | null> {
  const { data, error } = await supabase
    .from('chapters')
    .select(
      `
      *,
      guide:characters!chapters_guide_id_fkey(*)
    `
    )
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
  const { data, error } = await supabase.from('terms').select('*').eq('id', id).maybeSingle();

  if (error) throw error;
  return data;
}

/**
 * Sanitize a user-supplied string so it can be safely embedded
 * inside a PostgREST filter expression (.or / .ilike).
 * Escapes characters that have special meaning in the filter DSL:
 *   ,  (  )  \  %  _
 */
function sanitizeFilterValue(raw: string): string {
  return raw
    .replace(/\\/g, '\\\\')
    .replace(/%/g, '\\%')
    .replace(/_/g, '\\_')
    .replace(/,/g, '\\,')
    .replace(/\(/g, '\\(')
    .replace(/\)/g, '\\)');
}

export async function searchTerms(query: string): Promise<Term[]> {
  const safe = sanitizeFilterValue(query);
  const { data, error } = await supabase
    .from('terms')
    .select('*')
    .or(`term.ilike.%${safe}%,term_ja.ilike.%${safe}%,one_liner.ilike.%${safe}%`)
    .limit(20);

  if (error) throw error;
  return data || [];
}

export async function getCharacter(id: string): Promise<Character | null> {
  const { data, error } = await supabase.from('characters').select('*').eq('id', id).maybeSingle();

  if (error) throw error;
  return data;
}

export async function getCharacters(): Promise<Character[]> {
  const { data, error } = await supabase.from('characters').select('*').order('chapter_appearance');

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
  const { count, error } = await supabase.from('terms').select('*', { count: 'exact', head: true });

  if (error) throw error;
  return count || 0;
}

export async function getRandomTermsForQuiz(
  chapterId: number | null,
  count: number = 10
): Promise<Term[]> {
  const { data, error } = await supabase.rpc('get_random_terms', {
    p_chapter_id: chapterId,
    p_count: count,
  });

  if (error) throw error;
  return (data || []) as Term[];
}

type ButterflyStage = 'none' | 'light' | 'egg' | 'larva' | 'pupa' | 'butterfly';

export async function saveTermProgress(
  userId: string,
  termId: string,
  masteryLevel: number = 3,
  butterflyStage: ButterflyStage = 'butterfly'
): Promise<void> {
  const { data: existing } = await supabase
    .from('user_term_progress')
    .select('id')
    .eq('user_id', userId)
    .eq('term_id', termId)
    .maybeSingle();

  if (existing) {
    const { error: updateError } = await supabase
      .from('user_term_progress')
      .update({
        mastery_level: masteryLevel,
        butterfly_stage: butterflyStage,
        times_reviewed: 1,
        last_reviewed_at: new Date().toISOString(),
      })
      .eq('user_id', userId)
      .eq('term_id', termId);
    if (updateError) throw updateError;
  } else {
    const { error: insertError } = await supabase.from('user_term_progress').insert({
      user_id: userId,
      term_id: termId,
      mastery_level: masteryLevel,
      butterfly_stage: butterflyStage,
      times_reviewed: 1,
      last_reviewed_at: new Date().toISOString(),
    });
    if (insertError) throw insertError;
  }
}

export async function saveMultipleTermProgress(
  userId: string,
  termIds: string[],
  masteryLevel: number = 3,
  butterflyStage: ButterflyStage = 'butterfly'
): Promise<void> {
  if (termIds.length === 0) return;

  const now = new Date().toISOString();
  const rows = termIds.map((termId) => ({
    user_id: userId,
    term_id: termId,
    mastery_level: masteryLevel,
    butterfly_stage: butterflyStage,
    times_reviewed: 1,
    last_reviewed_at: now,
  }));

  const { error } = await supabase
    .from('user_term_progress')
    .upsert(rows, { onConflict: 'user_id,term_id' });

  if (error) throw error;
}

export async function getUserButterflyCount(userId: string): Promise<number> {
  const { count, error } = await supabase
    .from('user_term_progress')
    .select('*', { count: 'exact', head: true })
    .eq('user_id', userId)
    .eq('butterfly_stage', 'butterfly');

  if (error) throw error;
  return count || 0;
}

export async function updateUserButterflyCount(userId: string, count: number): Promise<void> {
  const { error } = await supabase
    .from('user_profiles')
    .update({ total_butterflies: count })
    .eq('id', userId);
  if (error) throw error;
}

interface TermProgress {
  term_id: string;
  created_at: string;
}

export async function getUserCollectedTerms(userId: string): Promise<TermProgress[]> {
  const { data, error } = await supabase
    .from('user_term_progress')
    .select('term_id, created_at')
    .eq('user_id', userId)
    .eq('butterfly_stage', 'butterfly');

  if (error) throw error;
  return (data || []) as TermProgress[];
}

export async function getTermsByIds(termIds: string[]): Promise<Term[]> {
  if (termIds.length === 0) return [];

  const { data, error } = await supabase.from('terms').select('*').in('id', termIds);

  if (error) throw error;
  return data || [];
}
