/*
  # Rename Digitaria to Digitalia in story scenes

  1. Modified Tables
    - `story_scenes`
      - Update `content_en` in 3 scenes (ch1 scene 2, ch1 scene 3, ch2 scene 1)
        where the world name "Digitaria" appears in English text
      - Changed to "Digitalia" to match the corrected app name

  2. Notes
    - Japanese content (`content`) uses katakana "デジタリア" which is
      unchanged since it works for both romanizations
    - Only the English content_en column is affected
*/

UPDATE story_scenes
SET content_en = REPLACE(content_en, 'Digitaria', 'Digitalia')
WHERE content_en LIKE '%Digitaria%';
