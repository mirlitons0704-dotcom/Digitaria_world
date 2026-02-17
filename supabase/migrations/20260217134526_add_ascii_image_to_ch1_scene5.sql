/*
  # Add ASCII table image to Chapter 1 Scene 5

  1. Modified Tables
    - `story_scenes`: Updated content for Chapter 1, Scene 5 ("文字の秘密")
      - Inserted ASCII.png image from Supabase storage after the line about "約束事なんです"

  2. Important Notes
    - Uses the existing {{image:URL}} marker pattern for inline images
    - Image is stored in the `assets` bucket in Supabase Storage
*/

UPDATE story_scenes
SET content = 'バイトさんが、不思議な表を見せてくれた。

「これは ASCII（アスキー）コード表といいます。
私たち1バイトで、どの数字がどの文字を表すか決めた約束事なんです」

{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png}}

表を見ると、「65」の横に「A」、「66」の横に「B」と書いてある。

「つまり、コンピュータが『01000001』という0と1の並びを見たら、『A』という文字だとわかるってこと？」

「その通りです」

ビットくんが嬉しそうに跳ねた。

「すごいでしょ！ぼくたちの並び方で、文字になったり、数字になったり、いろんなものを表現できるんだ！」'
WHERE id = '0b8f6350-d274-48ee-8bb0-07985cf1683a';