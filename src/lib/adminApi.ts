import { supabase } from './supabase';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL as string;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

export interface AdminUser {
  id: string;
  username: string;
  email: string;
  is_admin: boolean;
  created_at: string;
  display_name: string | null;
  total_butterflies: number;
  current_chapter: number;
}

export interface UserDetail extends AdminUser {
  terms_mastered: number;
  chapters_completed: number;
  quiz_count: number;
  last_activity: string | null;
}

export interface AnalyticsOverview {
  totalUsers: number;
  totalTermsMastered: number;
  totalQuizzesTaken: number;
  averageButterflies: number;
}

export interface ChapterStats {
  chapter_id: number;
  title: string;
  term_count: number;
  users_started: number;
  users_completed: number;
  avg_terms_mastered: number;
}

export interface DifficultyBreakdown {
  difficulty: number;
  total: number;
  mastered: number;
}

export interface ButterflyDistribution {
  stage: string;
  count: number;
}

interface ProfileRow {
  id: string;
  username: string;
  email: string;
  is_admin: boolean;
  created_at: string;
}

interface UserProfileRow {
  id: string;
  display_name: string | null;
  total_butterflies: number;
  current_chapter: number;
}

interface ChapterProgressRow {
  chapter_id: number;
  is_unlocked: boolean;
  is_completed: boolean;
  terms_mastered: number;
}

export async function getAdminUsers(): Promise<AdminUser[]> {
  const { data: profiles, error: profileError } = await supabase
    .from('profiles')
    .select('id, username, email, is_admin, created_at')
    .order('created_at', { ascending: false });

  if (profileError) throw profileError;

  const typedProfiles = (profiles || []) as unknown as ProfileRow[];
  const userIds = typedProfiles.map((p) => p.id);
  if (userIds.length === 0) return [];

  const { data: userProfiles } = await supabase
    .from('user_profiles')
    .select('id, display_name, total_butterflies, current_chapter')
    .in('id', userIds);

  const typedUserProfiles = (userProfiles || []) as unknown as UserProfileRow[];
  const profileMap = new Map(typedUserProfiles.map((up) => [up.id, up]));

  return typedProfiles.map((p) => {
    const up = profileMap.get(p.id);
    return {
      ...p,
      display_name: up?.display_name ?? null,
      total_butterflies: up?.total_butterflies ?? 0,
      current_chapter: up?.current_chapter ?? 1,
    };
  });
}

export async function getAdminUserDetail(userId: string): Promise<UserDetail | null> {
  const { data: profile } = await supabase
    .from('profiles')
    .select('id, username, email, is_admin, created_at')
    .eq('id', userId)
    .maybeSingle();

  if (!profile) return null;

  const typedProfile = profile as unknown as ProfileRow;

  const { data: userProfile } = await supabase
    .from('user_profiles')
    .select('display_name, total_butterflies, current_chapter')
    .eq('id', userId)
    .maybeSingle();

  const typedUP = userProfile as unknown as {
    display_name: string | null;
    total_butterflies: number;
    current_chapter: number;
  } | null;

  const { count: termsMastered } = await supabase
    .from('user_term_progress')
    .select('*', { count: 'exact', head: true })
    .eq('user_id', userId)
    .eq('butterfly_stage', 'butterfly');

  const { count: chaptersCompleted } = await supabase
    .from('user_chapter_progress')
    .select('*', { count: 'exact', head: true })
    .eq('user_id', userId)
    .eq('is_completed', true);

  const { count: quizCount } = await supabase
    .from('quiz_history')
    .select('*', { count: 'exact', head: true })
    .eq('user_id', userId);

  const { data: lastProgress } = await supabase
    .from('user_term_progress')
    .select('updated_at')
    .eq('user_id', userId)
    .order('updated_at', { ascending: false })
    .limit(1);

  const typedLastProgress = (lastProgress || []) as unknown as {
    updated_at: string;
  }[];

  return {
    ...typedProfile,
    display_name: typedUP?.display_name ?? null,
    total_butterflies: typedUP?.total_butterflies ?? 0,
    current_chapter: typedUP?.current_chapter ?? 1,
    terms_mastered: termsMastered ?? 0,
    chapters_completed: chaptersCompleted ?? 0,
    quiz_count: quizCount ?? 0,
    last_activity: typedLastProgress[0]?.updated_at ?? null,
  };
}

export async function getAnalyticsOverview(): Promise<AnalyticsOverview> {
  const { count: totalUsers } = await supabase
    .from('profiles')
    .select('*', { count: 'exact', head: true });

  const { count: totalTermsMastered } = await supabase
    .from('user_term_progress')
    .select('*', { count: 'exact', head: true })
    .eq('butterfly_stage', 'butterfly');

  const { count: totalQuizzesTaken } = await supabase
    .from('quiz_history')
    .select('*', { count: 'exact', head: true });

  const { data: butterflyData } = await supabase.from('user_profiles').select('total_butterflies');

  const typedButterflyData = (butterflyData || []) as unknown as {
    total_butterflies: number;
  }[];

  const totalButterflies = typedButterflyData.reduce(
    (sum, u) => sum + (u.total_butterflies || 0),
    0
  );
  const userCount = typedButterflyData.length || 1;

  return {
    totalUsers: totalUsers ?? 0,
    totalTermsMastered: totalTermsMastered ?? 0,
    totalQuizzesTaken: totalQuizzesTaken ?? 0,
    averageButterflies: Math.round(totalButterflies / userCount),
  };
}

export async function getChapterAnalytics(): Promise<ChapterStats[]> {
  const { data: chapters } = await supabase
    .from('chapters')
    .select('id, title, term_count')
    .order('id');

  if (!chapters) return [];

  const typedChapters = chapters as unknown as {
    id: number;
    title: string;
    term_count: number;
  }[];

  const { data: chapterProgress } = await supabase
    .from('user_chapter_progress')
    .select('chapter_id, is_unlocked, is_completed, terms_mastered');

  const typedProgress = (chapterProgress || []) as unknown as ChapterProgressRow[];

  const progressMap = new Map<
    number,
    { started: number; completed: number; totalMastered: number }
  >();

  for (const cp of typedProgress) {
    const existing = progressMap.get(cp.chapter_id) || {
      started: 0,
      completed: 0,
      totalMastered: 0,
    };
    if (cp.is_unlocked) existing.started++;
    if (cp.is_completed) existing.completed++;
    existing.totalMastered += cp.terms_mastered || 0;
    progressMap.set(cp.chapter_id, existing);
  }

  return typedChapters.map((ch) => {
    const stats = progressMap.get(ch.id);
    return {
      chapter_id: ch.id,
      title: ch.title,
      term_count: ch.term_count,
      users_started: stats?.started ?? 0,
      users_completed: stats?.completed ?? 0,
      avg_terms_mastered:
        stats && stats.started > 0 ? Math.round(stats.totalMastered / stats.started) : 0,
    };
  });
}

export async function getButterflyDistribution(): Promise<ButterflyDistribution[]> {
  const stages = ['none', 'light', 'egg', 'larva', 'pupa', 'butterfly'] as const;

  // Single query instead of 6 separate queries
  const { data, error } = await supabase.from('user_term_progress').select('butterfly_stage');

  if (error) throw error;

  const typedData = (data || []) as unknown as { butterfly_stage: string }[];
  const countMap = new Map<string, number>();
  for (const row of typedData) {
    countMap.set(row.butterfly_stage, (countMap.get(row.butterfly_stage) || 0) + 1);
  }

  return stages.map((stage) => ({ stage, count: countMap.get(stage) ?? 0 }));
}

export async function getDifficultyBreakdown(): Promise<DifficultyBreakdown[]> {
  // 2 queries instead of 9: fetch all terms + all mastered progress
  const { data: allTerms, error: termsError } = await supabase
    .from('terms')
    .select('id, difficulty');

  if (termsError) throw termsError;

  const typedTerms = (allTerms || []) as unknown as { id: string; difficulty: number }[];

  // Group term IDs by difficulty
  const termsByDifficulty = new Map<number, string[]>();
  for (const t of typedTerms) {
    const ids = termsByDifficulty.get(t.difficulty) || [];
    ids.push(t.id);
    termsByDifficulty.set(t.difficulty, ids);
  }

  const { data: masteredData, error: progressError } = await supabase
    .from('user_term_progress')
    .select('term_id')
    .eq('butterfly_stage', 'butterfly');

  if (progressError) throw progressError;

  const typedMastered = (masteredData || []) as unknown as { term_id: string }[];
  const masteredTermIds = new Set(typedMastered.map((m) => m.term_id));

  return [1, 2, 3].map((difficulty) => {
    const ids = termsByDifficulty.get(difficulty) || [];
    const mastered = ids.filter((id) => masteredTermIds.has(id)).length;
    return { difficulty, total: ids.length, mastered };
  });
}

export async function getRecentSignups(
  limit: number = 10
): Promise<{ id: string; username: string; email: string; created_at: string }[]> {
  const { data, error } = await supabase
    .from('profiles')
    .select('id, username, email, created_at')
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) throw error;
  return (data || []) as unknown as {
    id: string;
    username: string;
    email: string;
    created_at: string;
  }[];
}

export async function getTopLearners(
  limit: number = 10
): Promise<{ id: string; display_name: string | null; total_butterflies: number }[]> {
  const { data, error } = await supabase
    .from('user_profiles')
    .select('id, display_name, total_butterflies')
    .order('total_butterflies', { ascending: false })
    .limit(limit);

  if (error) throw error;
  return (data || []) as unknown as {
    id: string;
    display_name: string | null;
    total_butterflies: number;
  }[];
}

// ---------------------------------------------------------------------------
// Illustration management helpers
// ---------------------------------------------------------------------------

export interface IllustrationScene {
  id: string;
  chapter_id: number;
  scene_number: number;
  title: string | null;
  image_url: string | null;
  inline_image_count: number;
  inline_image_urls: string[];
  content: string;
}

async function callManageIllustration(body: Record<string, unknown>) {
  const {
    data: { session },
  } = await supabase.auth.getSession();

  const token = session?.access_token;
  if (!token) throw new Error('Authentication required');

  const res = await fetch(`${SUPABASE_URL}/functions/v1/manage-illustration`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
      apikey: SUPABASE_ANON_KEY,
    },
    body: JSON.stringify(body),
  });

  const json = await res.json();
  if (!res.ok) throw new Error(json.error || `Request failed (${res.status})`);
  return json;
}

export async function getIllustrationScenes(chapterId?: number): Promise<IllustrationScene[]> {
  const body: Record<string, unknown> = { action: 'list' };
  if (chapterId) body.chapterId = chapterId;
  const { scenes } = await callManageIllustration(body);
  return scenes;
}

export async function uploadIllustration(
  base64: string,
  filename: string
): Promise<{ path: string; publicUrl: string }> {
  return callManageIllustration({
    action: 'upload',
    base64,
    filename,
  });
}

export async function setSceneImageUrl(sceneId: string, url: string | null): Promise<void> {
  await callManageIllustration({
    action: 'set-image-url',
    sceneId,
    url,
  });
}

export async function insertInlineImage(
  sceneId: string,
  url: string,
  paragraphIndex: number
): Promise<{ content: string }> {
  return callManageIllustration({
    action: 'insert-inline',
    sceneId,
    url,
    paragraphIndex,
  });
}

export async function removeInlineImage(
  sceneId: string,
  imageUrl: string
): Promise<{ content: string }> {
  return callManageIllustration({
    action: 'remove-image',
    sceneId,
    imageUrl,
  });
}
