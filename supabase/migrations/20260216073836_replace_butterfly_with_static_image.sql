/*
  # Replace butterfly media with static image

  1. Changes
    - Replace `{{image:...code-butterfly.png}}` with `{{image:...butterfly1.png}}`
    - Replace `{{video:...code-butterfly.mp4}}` with `{{image:...butterfly1.png}}`
    - Both image and video markers now use the same butterfly1.png static image

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 3 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  REPLACE(
    content,
    '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.png}}',
    '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/butterfly1.png}}'
  ),
  '{{video:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.mp4}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/butterfly1.png}}'
)
WHERE chapter_id = 1 AND scene_number = 3;