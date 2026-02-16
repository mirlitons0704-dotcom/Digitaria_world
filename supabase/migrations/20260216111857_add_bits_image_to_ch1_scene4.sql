/*
  # Add bits.png image to chapter 1 scene 4

  1. Changes
    - Insert bits.png image after the line "ぼくたちビットは、8人集まると『バイト』になるんだ」"
    - Image uses the {{image:...}} marker format

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 4 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  'ぼくたちビットは、8人集まると『バイト』になるんだ」',
  'ぼくたちビットは、8人集まると『バイト』になるんだ」' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png}}'
)
WHERE chapter_id = 1 AND scene_number = 4;