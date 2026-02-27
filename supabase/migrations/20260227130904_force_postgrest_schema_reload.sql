/*
  # Force PostgREST schema cache reload

  The previous NOTIFY-only migration did not reliably trigger
  PostgREST to pick up the content_en column added via a
  conditional DO $$ block.

  This migration performs an actual DDL change (setting an explicit
  DEFAULT on content_en) which PostgREST detects automatically,
  forcing a full schema cache reload.
*/

ALTER TABLE story_scenes
  ALTER COLUMN content_en SET DEFAULT NULL;

NOTIFY pgrst, 'reload schema';
