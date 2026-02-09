/*
  # Fix security and performance issues

  1. Unused Indexes Removed
    - `idx_quiz_history_user` on `quiz_history`
    - `idx_chapters_guide_id` on `chapters`
    - `idx_chapters_support_guide_id` on `chapters`
    - `idx_quiz_history_chapter_id` on `quiz_history`
    - `idx_user_chapter_progress_chapter_id` on `user_chapter_progress`
    - `idx_profiles_is_admin` on `profiles`
    - `idx_user_term_progress_user` on `user_term_progress`
    - `idx_user_term_progress_term` on `user_term_progress`
    - `idx_user_chapter_progress_user` on `user_chapter_progress`

  2. Multiple Permissive Policies Consolidated
    - For each of 5 tables (profiles, quiz_history, user_chapter_progress, user_profiles, user_term_progress),
      the separate "Users can read own" and "Admins can read all" SELECT policies
      are replaced with a single combined policy that checks ownership OR admin status.

  3. Function Search Path Fixed
    - `public.update_updated_at` recreated with immutable `search_path = ''`

  4. Important Notes
    - All existing RLS access patterns are preserved (users see own data, admins see all)
    - No data is modified or deleted
    - The function body remains identical; only the search_path attribute changes
*/

-- ============================================================
-- 1. Drop unused indexes
-- ============================================================

DROP INDEX IF EXISTS public.idx_quiz_history_user;
DROP INDEX IF EXISTS public.idx_chapters_guide_id;
DROP INDEX IF EXISTS public.idx_chapters_support_guide_id;
DROP INDEX IF EXISTS public.idx_quiz_history_chapter_id;
DROP INDEX IF EXISTS public.idx_user_chapter_progress_chapter_id;
DROP INDEX IF EXISTS public.idx_profiles_is_admin;
DROP INDEX IF EXISTS public.idx_user_term_progress_user;
DROP INDEX IF EXISTS public.idx_user_term_progress_term;
DROP INDEX IF EXISTS public.idx_user_chapter_progress_user;

-- ============================================================
-- 2. Consolidate multiple permissive SELECT policies
-- ============================================================

-- profiles
DROP POLICY IF EXISTS "Users can read own profile" ON public.profiles;
DROP POLICY IF EXISTS "Admins can read all profiles" ON public.profiles;
CREATE POLICY "Users can read own profile or admin reads all"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (
    (id = ( SELECT auth.uid() AS uid))
    OR
    ( SELECT is_admin() AS is_admin)
  );

-- quiz_history
DROP POLICY IF EXISTS "Users can view own quiz history" ON public.quiz_history;
DROP POLICY IF EXISTS "Admins can read all quiz history" ON public.quiz_history;
CREATE POLICY "Users can read own quiz history or admin reads all"
  ON public.quiz_history
  FOR SELECT
  TO authenticated
  USING (
    (user_id = ( SELECT auth.uid() AS uid))
    OR
    ( SELECT is_admin() AS is_admin)
  );

-- user_chapter_progress
DROP POLICY IF EXISTS "Users can view own chapter progress" ON public.user_chapter_progress;
DROP POLICY IF EXISTS "Admins can read all chapter progress" ON public.user_chapter_progress;
CREATE POLICY "Users can read own chapter progress or admin reads all"
  ON public.user_chapter_progress
  FOR SELECT
  TO authenticated
  USING (
    (user_id = ( SELECT auth.uid() AS uid))
    OR
    ( SELECT is_admin() AS is_admin)
  );

-- user_profiles
DROP POLICY IF EXISTS "Users can view own profile" ON public.user_profiles;
DROP POLICY IF EXISTS "Admins can read all user profiles" ON public.user_profiles;
CREATE POLICY "Users can read own user profile or admin reads all"
  ON public.user_profiles
  FOR SELECT
  TO authenticated
  USING (
    (id = ( SELECT auth.uid() AS uid))
    OR
    ( SELECT is_admin() AS is_admin)
  );

-- user_term_progress
DROP POLICY IF EXISTS "Users can view own term progress" ON public.user_term_progress;
DROP POLICY IF EXISTS "Admins can read all term progress" ON public.user_term_progress;
CREATE POLICY "Users can read own term progress or admin reads all"
  ON public.user_term_progress
  FOR SELECT
  TO authenticated
  USING (
    (user_id = ( SELECT auth.uid() AS uid))
    OR
    ( SELECT is_admin() AS is_admin)
  );

-- ============================================================
-- 3. Fix mutable search_path on update_updated_at function
-- ============================================================

CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = ''
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;