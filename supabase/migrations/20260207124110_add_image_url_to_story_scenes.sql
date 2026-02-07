/*
  # Add image_url column to story_scenes

  1. Modified Tables
    - `story_scenes`
      - Added `image_url` (text, nullable) - optional character/narrative image URL displayed within the scene

  2. Data Updates
    - Set n1_bit.png image on Chapter 1, Scene 2 ("ビットくんとの出会い")

  3. Notes
    - Column is nullable so existing scenes without images are unaffected
    - Enables character illustrations to appear at key story moments
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'story_scenes' AND column_name = 'image_url'
  ) THEN
    ALTER TABLE story_scenes ADD COLUMN image_url text;
  END IF;
END $$;

UPDATE story_scenes
SET image_url = 'https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/n1_bit.png'
WHERE chapter_id = 1 AND scene_number = 2;