/*
  # Revert first butterfly image to code-butterfly.png

  1. Changes
    - First image (after "きれい……") reverted to code-butterfly.png
    - Second image (after "ほんのり温かい。") remains butterfly1.png

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 3 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  '「きれい……」' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/butterfly1.png}}',
  '「きれい……」' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.png}}'
)
WHERE chapter_id = 1 AND scene_number = 3;