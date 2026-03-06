/*
  # Add admin UPDATE policy for story_scenes

  1. Changes
    - Add UPDATE policy on `story_scenes` allowing admins to update content
      (e.g. speaker tags via the Admin Story Editor)

  2. Security
    - Only users with `is_admin = true` in the profiles table can update story_scenes
    - Uses the existing `is_admin()` SECURITY DEFINER helper function
*/

CREATE POLICY "Admins can update story scenes"
  ON public.story_scenes
  FOR UPDATE
  TO authenticated
  USING ((select public.is_admin()))
  WITH CHECK ((select public.is_admin()));
