/*
  # Add RPC function for random term selection

  Previously, getRandomTermsForQuiz fetched ALL terms and shuffled client-side.
  This RPC function performs the randomization in PostgreSQL for better scalability.
*/

CREATE OR REPLACE FUNCTION get_random_terms(
  p_chapter_id integer DEFAULT NULL,
  p_count integer DEFAULT 10
)
RETURNS SETOF terms
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT *
  FROM terms
  WHERE (p_chapter_id IS NULL OR chapter_id = p_chapter_id)
  ORDER BY random()
  LIMIT p_count;
$$;
