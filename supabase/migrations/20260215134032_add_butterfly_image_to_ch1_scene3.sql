/*
  # Add butterfly image to Chapter 1 Scene 3

  1. Changes
    - Updates the `content` column of Chapter 1, Scene 3 ("コードバタフライとの出会い")
    - Inserts an inline image marker `{{image:/code-butterfly.png}}` between the
      「きれい……」 and 「あれは『コードバタフライ』」 paragraphs
    - The marker is rendered by the StoryTeleprompter component as an inline image

  2. Notes
    - The image marker syntax `{{image:/path}}` is a convention used by the frontend
    - TTS (text-to-speech) strips these markers before generating audio
    - This does not affect any other scenes or chapters
*/

UPDATE story_scenes
SET content = E'ビットくんと歩き始めると、ふわりと光が舞った。\n\n「あ……蝶？」\n\n見上げると、光り輝く蝶が何匹か飛んでいる。\nよく見ると、羽は0と1の粒子でできていて、羽ばたくたびにキラキラと輝いていた。\n\n「きれい……」\n\n{{image:/code-butterfly.png}}\n\n「あれは『コードバタフライ』」\nビットくんが嬉しそうに言った。\n\n「この世界に住む、とても大切な存在なんだ。\nコードバタフライは、知識の記憶を運んでいるんだよ」\n\n「知識の記憶を……運ぶ？」\n\n「そう。デジタリアには、たくさんの『用語』という花が咲いているんだ。コードバタフライは、花から花へと飛び回って、意味を受粉させるように広げていく。おかげで、この世界の知識はバラバラじゃなくて、ちゃんと繋がっているんだ」\n\n一匹の蝶が、あなたの指先にそっと止まった。\n羽が触れた場所が、ほんのり温かい。\n\n「わ……」\n\n「気に入られたみたいだね」\nビットくんが微笑んだ。\n\n「そしてね、もうひとつ大切なことがある。\nきみが用語を本当に理解したとき——\nただ覚えただけじゃなくて、心から『わかった！』と思えたとき——\nその知識は光の粒になって、新しい蝶が生まれるんだ」\n\n「ぼくが学ぶと、蝶が……？」\n\n「うん。最初は小さな光の粒。\nでも学びが深まるにつれて、それは卵になり、幼虫になり、さなぎになり……\nそしていつか、こうして美しい蝶になって羽ばたく」\n\nビットくんは遠くを指さした。\n丘の向こうに、無数の光が舞っているのが見える。\n\n「あそこは『メモリーガーデン』。\n500の言葉を学び終えた人だけが行ける、特別な場所だよ」\n\n「500……」\n\n「この旅で学ぶ用語の数さ。\n全部の言葉を理解したとき、きみの蝶たちがあの丘を舞っているはずだよ」\n\n光の蝶が指先から飛び立ち、仲間と一緒に空へ消えていった。\n\nあなたは心に決めた。\nいつか、あの丘で自分の蝶たちに会いに行こう、と。'
WHERE chapter_id = 1 AND scene_number = 3;