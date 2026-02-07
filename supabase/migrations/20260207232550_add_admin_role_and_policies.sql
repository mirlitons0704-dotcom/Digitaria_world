/*
  # Add Admin Role and Policies

  1. Changes
    - Add `is_admin` boolean column to `profiles` table (default false)
    - Create helper function `is_admin()` to check current user's admin status
    - Add admin RLS policies to allow admins to read all user data:
      - profiles: Admin can read all profiles
      - user_profiles: Admin can read all user profiles
      - user_term_progress: Admin can read all progress data
      - user_chapter_progress: Admin can read all chapter progress
      - quiz_history: Admin can read all quiz history

  2. Security
    - `is_admin` column cannot be updated by regular users (no UPDATE policy for it)
    - Admin status checked via SECURITY DEFINER function reading profiles table
    - All admin policies are SELECT-only (read-only access to user data)
    - Only admins with `is_admin = true` in profiles table get elevated access

  3. Notes
    - To make a user an admin, update profiles table directly in Supabase dashboard:
      UPDATE profiles SET is_admin = true WHERE email = 'admin@example.com';
    - The is_admin function is cached per-statement via (select ...) pattern
*/

-- Add is_admin column to profiles
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'profiles' AND column_name = 'is_admin'
  ) THEN
    ALTER TABLE public.profiles ADD COLUMN is_admin boolean DEFAULT false NOT NULL;
  END IF;
END $$;

-- Create helper function to check admin status
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND is_admin = true
  );
END;
$$;

-- Admin can read all profiles
CREATE POLICY "Admins can read all profiles"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING ((select public.is_admin()));

-- Admin can read all user_profiles
CREATE POLICY "Admins can read all user profiles"
  ON public.user_profiles
  FOR SELECT
  TO authenticated
  USING ((select public.is_admin()));

-- Admin can read all user_term_progress
CREATE POLICY "Admins can read all term progress"
  ON public.user_term_progress
  FOR SELECT
  TO authenticated
  USING ((select public.is_admin()));

-- Admin can read all user_chapter_progress
CREATE POLICY "Admins can read all chapter progress"
  ON public.user_chapter_progress
  FOR SELECT
  TO authenticated
  USING ((select public.is_admin()));

-- Admin can read all quiz_history
CREATE POLICY "Admins can read all quiz history"
  ON public.quiz_history
  FOR SELECT
  TO authenticated
  USING ((select public.is_admin()));

-- Index for faster admin lookups
CREATE INDEX IF NOT EXISTS idx_profiles_is_admin ON public.profiles(is_admin) WHERE is_admin = true;
