/*
  # Add bite.png image to chapter 1 scene 4

  1. Changes
    - Insert bite.png image after "穏やかな声だった。"
    - Image uses the {{image:...}} marker format

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 4 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  '穏やかな声だった。',
  '穏やかな声だった。' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bite.png}}'
)
WHERE chapter_id = 1 AND scene_number = 4;