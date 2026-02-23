/*
  # Update Chapter 5 scenes 4 and 5 to masculine speech

  1. Story Scene Changes
    - Scene 4 (スタイルの書き方): feminine endings → masculine (の→んだ, よ→だよ, ね→な)
    - Scene 5 (箱モデル): CSSちゃん→CSSくん, feminine endings → masculine (の→んだ, わ→よ)

  2. Notes
    - Consistent with previous migration making CSS a male twin
*/

UPDATE story_scenes
SET content = E'「Style（スタイル）の書き方は3種類あるんだ」\n\n「Stylesheet（スタイルシート）は、別ファイルにCSSをまとめる方法。一番おすすめだよ」\n\n「Inline style（インラインスタイル）は、タグに直接書く方法。緊急のときだけにしてな」\n\n「整理されたスタイルシートが、保守しやすいサイトの秘訣だよ」'
WHERE id = 'eb097ad2-c1d2-484e-a478-28e614c7fba1';

UPDATE story_scenes
SET content = E'「すべての要素は『箱』なんだ」\n\nCSS くんが図を描いた。\n\n「Box model（ボックスモデル）を理解すれば、レイアウトがわかるよ」\n\n「Margin は要素の外側の余白」\n「Padding は要素の内側の余白」\n「Border は要素の枠線」\n\n「この3つを調整すれば、思い通りの配置ができるよ」'
WHERE id = 'c304bcb2-f1a6-40bb-95e7-02cbf19d8cee';