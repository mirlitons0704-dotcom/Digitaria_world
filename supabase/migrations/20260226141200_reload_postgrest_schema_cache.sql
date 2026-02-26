/*
  # Reload PostgREST schema cache

  The content_en and image_url columns were added via conditional
  DO $$ blocks which don't trigger PostgREST's automatic schema
  reload. This migration explicitly notifies PostgREST to reload
  its schema cache so select('*') includes all columns.
*/

NOTIFY pgrst, 'reload schema';
