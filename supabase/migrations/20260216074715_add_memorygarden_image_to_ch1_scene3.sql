/*
  # Add memorygarden.png image to chapter 1 scene 3

  1. Changes
    - Insert memorygarden.png image before the line "「あそこは『メモリーガーデン』。"
    - Image uses the same {{image:...}} marker format

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 3 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  '「あそこは『メモリーガーデン』。',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png}}' || E'\n\n' || '「あそこは『メモリーガーデン』。'
)
WHERE chapter_id = 1 AND scene_number = 3;