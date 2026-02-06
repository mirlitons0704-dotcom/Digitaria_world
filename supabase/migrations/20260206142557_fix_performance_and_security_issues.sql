/*
  # Fix Performance and Security Issues
  
  1. Performance Improvements
    - Add indexes on foreign keys for better query performance:
      - chapters.guide_id
      - chapters.support_guide_id
      - quiz_history.chapter_id
      - user_chapter_progress.chapter_id
    
  2. RLS Policy Optimization
    - Update all RLS policies to use (select auth.uid()) instead of auth.uid()
    - This prevents re-evaluation for each row, improving query performance at scale
    - Affected tables:
      - user_profiles (3 policies)
      - user_term_progress (3 policies)
      - user_chapter_progress (3 policies)
      - quiz_history (2 policies)
      - profiles (3 policies)
*/

-- Add missing indexes on foreign keys
CREATE INDEX IF NOT EXISTS idx_chapters_guide_id ON public.chapters(guide_id);
CREATE INDEX IF NOT EXISTS idx_chapters_support_guide_id ON public.chapters(support_guide_id);
CREATE INDEX IF NOT EXISTS idx_quiz_history_chapter_id ON public.quiz_history(chapter_id);
CREATE INDEX IF NOT EXISTS idx_user_chapter_progress_chapter_id ON public.user_chapter_progress(chapter_id);

-- Optimize RLS policies for user_profiles
DROP POLICY IF EXISTS "Users can view own profile" ON public.user_profiles;
CREATE POLICY "Users can view own profile"
  ON public.user_profiles
  FOR SELECT
  TO authenticated
  USING (id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can update own profile" ON public.user_profiles;
CREATE POLICY "Users can update own profile"
  ON public.user_profiles
  FOR UPDATE
  TO authenticated
  USING (id = (select auth.uid()))
  WITH CHECK (id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can insert own profile" ON public.user_profiles;
CREATE POLICY "Users can insert own profile"
  ON public.user_profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (id = (select auth.uid()));

-- Optimize RLS policies for user_term_progress
DROP POLICY IF EXISTS "Users can view own term progress" ON public.user_term_progress;
CREATE POLICY "Users can view own term progress"
  ON public.user_term_progress
  FOR SELECT
  TO authenticated
  USING (user_id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can insert own term progress" ON public.user_term_progress;
CREATE POLICY "Users can insert own term progress"
  ON public.user_term_progress
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can update own term progress" ON public.user_term_progress;
CREATE POLICY "Users can update own term progress"
  ON public.user_term_progress
  FOR UPDATE
  TO authenticated
  USING (user_id = (select auth.uid()))
  WITH CHECK (user_id = (select auth.uid()));

-- Optimize RLS policies for user_chapter_progress
DROP POLICY IF EXISTS "Users can view own chapter progress" ON public.user_chapter_progress;
CREATE POLICY "Users can view own chapter progress"
  ON public.user_chapter_progress
  FOR SELECT
  TO authenticated
  USING (user_id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can insert own chapter progress" ON public.user_chapter_progress;
CREATE POLICY "Users can insert own chapter progress"
  ON public.user_chapter_progress
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can update own chapter progress" ON public.user_chapter_progress;
CREATE POLICY "Users can update own chapter progress"
  ON public.user_chapter_progress
  FOR UPDATE
  TO authenticated
  USING (user_id = (select auth.uid()))
  WITH CHECK (user_id = (select auth.uid()));

-- Optimize RLS policies for quiz_history
DROP POLICY IF EXISTS "Users can view own quiz history" ON public.quiz_history;
CREATE POLICY "Users can view own quiz history"
  ON public.quiz_history
  FOR SELECT
  TO authenticated
  USING (user_id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can insert own quiz history" ON public.quiz_history;
CREATE POLICY "Users can insert own quiz history"
  ON public.quiz_history
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = (select auth.uid()));

-- Optimize RLS policies for profiles
DROP POLICY IF EXISTS "Users can read own profile" ON public.profiles;
CREATE POLICY "Users can read own profile"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can insert own profile" ON public.profiles;
CREATE POLICY "Users can insert own profile"
  ON public.profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (id = (select auth.uid()));

DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile"
  ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (id = (select auth.uid()))
  WITH CHECK (id = (select auth.uid()));