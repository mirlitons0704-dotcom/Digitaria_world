/*
  # Add size hints to existing inline image markers

  Updates existing {{image:url}} markers that need non-default sizes:
  - bits.png → |size=full (diagram showing 8 bits)
  - memorygarden.png → |size=lg (landscape illustration)
  - ASCII.png → |size=lg (reference table)

  All other existing markers remain unchanged and render at the default 'md' size.
*/

-- bits.png → full width
UPDATE story_scenes
SET content = REPLACE(
  content,
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png|size=full}}'
)
WHERE content LIKE '%{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png}}%';

-- memorygarden.png → lg
UPDATE story_scenes
SET content = REPLACE(
  content,
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png|size=lg}}'
)
WHERE content LIKE '%{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png}}%';

-- ASCII.png → lg
UPDATE story_scenes
SET content = REPLACE(
  content,
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png|size=lg}}'
)
WHERE content LIKE '%{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png}}%';
