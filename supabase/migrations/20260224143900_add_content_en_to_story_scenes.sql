/*
  # Add English content column to story_scenes

  Adds an optional `content_en` column so that story text
  can be displayed in either Japanese (existing `content`) or English.
  When `content_en` is NULL the UI falls back to the Japanese text.
*/

ALTER TABLE story_scenes
  ADD COLUMN IF NOT EXISTS content_en text;

COMMENT ON COLUMN story_scenes.content_en IS 'English translation of the story scene content. NULL = not yet translated (fallback to Japanese).';
