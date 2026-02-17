/*
  # Add library image to Chapter 1 Scene 11

  1. Changes
    - Update story_scenes row for chapter 1, scene 11 ("データの入れ物")
    - Set image_url to the library.png asset from Supabase Storage

  2. Notes
    - The image will appear before the text "最後に、図書館のような建物に案内された。"
*/

UPDATE story_scenes
SET image_url = 'https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/library.png'
WHERE id = '1de81af0-8f98-4e0c-84ad-2b92198790df';