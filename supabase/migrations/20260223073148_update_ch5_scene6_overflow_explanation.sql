/*
  # Update Chapter 5 Scene 6 - Improve Overflow explanation

  1. Modified Tables
    - `story_scenes`: Update content for chapter 5, scene 6
  2. Changes
    - Replace terse Overflow explanation with a clearer, more concrete description
    - Add mention of `hidden` value alongside `scroll` for better understanding
    - Maintain the existing male speech style (だよ / んだ)
*/

UPDATE story_scenes
SET content = '「Display（表示方法）と Position（位置）で配置を決めるんだ」とHTMLくん。

「display: block は縦に積み重なる」
「display: inline は横に並ぶ」
「display: none は非表示」

「position: relative は元の位置基準で調整」
「position: absolute は親要素基準で自由配置」
「position: fixed は画面に固定」

「Overflow（オーバーフロー）は、箱に入りきらない内容をどう扱うかを決めるプロパティだよ。hidden にすれば、はみ出た部分を隠す。scroll にすれば、スクロールして見られるようになるんだ」'
WHERE id = '1a558a74-ae85-4988-87bc-a2b5bc63dbe3';