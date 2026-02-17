/*
  # Replace print("HELLO") text with hello.png image in Chapter 1 Scene 7

  1. Modified Tables
    - `story_scenes`: Updated content for Chapter 1, Scene 7 ("人間の言葉に近づける")
      - Replaced the `print("HELLO")` text with hello.png image from Supabase Storage assets bucket

  2. Important Notes
    - Uses the existing {{image:URL}} marker pattern for inline images
    - Image is stored in the `assets` bucket in Supabase Storage
*/

UPDATE story_scenes
SET content = '次の場所には、もう少し読みやすい文字が並んでいた。

{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/hello.png}}

「これは Code（コード）——プログラミング言語で書かれた命令文だよ」

「あ、これなら少し読める気がする！」

「でしょ？人間が読み書きしやすいように作られた言葉なんだ。
これをコンピュータが理解できる機械語に変換してくれる仕組みがあるんだよ」

「通訳みたいなものかな？」

「そうそう！まさに通訳！
人間の言葉と機械語の橋渡しをしてくれるんだ」'
WHERE id = 'bd070e32-5027-45fe-b5a5-f17512a7d452';