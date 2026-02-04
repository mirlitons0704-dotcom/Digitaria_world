/*
  # Add Epilogue Guide Character and Chapter

  1. New Character
    - コードバタフライたち (Code Butterflies) - Guide for the Epilogue
    - Represents the butterflies that carry knowledge in Memory Garden

  2. New Chapter
    - Chapter 17: メモリーガーデン (Memory Garden)
    - The epilogue chapter with 20 bonus terms
*/

INSERT INTO characters (id, name, role, personality, speech_style)
VALUES (
  '00000000-0000-0000-0003-000000000003',
  'コードバタフライたち',
  '知識を運ぶ蝶の群れ',
  '優しく、希望に満ちている',
  '〜だよ、〜ね（親しみを込めた話し方）'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  personality = EXCLUDED.personality,
  speech_style = EXCLUDED.speech_style;

INSERT INTO chapters (id, title, subtitle, category, category_name, category_icon, description, guide_id, term_count)
VALUES (
  17,
  'メモリーガーデン',
  '旅の終わりに出会う言葉たち',
  'epilogue',
  'エピローグ',
  'sparkles',
  '500語の旅を終えた君へ。メモリーガーデンで蝶たちが、最後に大切な20の言葉を教えてくれる。これは旅の終わりではなく、新しい始まり。',
  '00000000-0000-0000-0003-000000000003',
  20
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  subtitle = EXCLUDED.subtitle,
  category = EXCLUDED.category,
  category_name = EXCLUDED.category_name,
  category_icon = EXCLUDED.category_icon,
  description = EXCLUDED.description,
  guide_id = EXCLUDED.guide_id,
  term_count = EXCLUDED.term_count;