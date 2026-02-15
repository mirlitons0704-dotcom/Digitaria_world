/*
  # Use Supabase Storage URL for butterfly image

  1. Changes
    - Updates the image marker in Chapter 1 Scene 3 from local path `/memorygarden.png`
      to the Supabase Storage public URL for `code-butterfly.png`
    - The image was uploaded by the user to the `assets` bucket
*/

UPDATE story_scenes
SET content = replace(
  content,
  '{{image:/memorygarden.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.png}}'
)
WHERE chapter_id = 1 AND scene_number = 3;