/*
  # Fix butterfly image path in Chapter 1 Scene 3

  1. Changes
    - Updates the image marker from `/code-butterfly.png` (0-byte file) to `/memorygarden.png`
    - The memorygarden.png shows ethereal glowing butterflies matching the scene description
*/

UPDATE story_scenes
SET content = replace(content, '{{image:/code-butterfly.png}}', '{{image:/memorygarden.png}}')
WHERE chapter_id = 1 AND scene_number = 3;