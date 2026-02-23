/*
  # Update Chapter 5 scenes 6-10 to masculine speech

  1. Story Scene Changes
    - Scene 6 (配置の魔法): 「できるわ」→「できるよ」
    - Scene 7 (最新のレイアウト): 「主流よ」→「主流だよ」, 「使うわ」→「使うんだ」, 「便利よ」→「便利だよ」, 「してね」→「してな」
    - Scene 8 (レスポンシブデザイン): 「使うの」→「使うんだ」, 「機能よ」→「機能だよ」
    - Scene 9 (意味のあるHTML): 「してね」→「してな」, 「属性よ」→「属性なんだ」
    - Scene 10 (埋め込みと囲み): 「箱よ」→「箱だよ」, 「使うの」→「使うんだ」

  2. Notes
    - Consistent with previous migrations making CSS a male twin
*/

UPDATE story_scenes
SET content = E'「Display（表示方法）と Position（位置）で配置を決めるんだ」とHTMLくん。\n\n「display: block は縦に積み重なる」\n「display: inline は横に並ぶ」\n「display: none は非表示」\n\n「position: relative は元の位置基準で調整」\n「position: absolute は親要素基準で自由配置」\n「position: fixed は画面に固定」\n\n「Overflow（オーバーフロー）は、はみ出した内容をどうするか。scroll にすればスクロールできるよ」'
WHERE id = '1a558a74-ae85-4988-87bc-a2b5bc63dbe3';

UPDATE story_scenes
SET content = E'「最近は Flexbox と Grid が主流だよ」\n\n「Grid（グリッド）は、2方向のレイアウトが得意。複雑なページ構成に使うんだ」\n\n「昔は Float（フロート）を使っていたけど、今は Grid の方が便利だよ。Float を使ったら Clear で解除してな」'
WHERE id = '66ccc55c-43ff-42d1-93b1-70079842ae83';

UPDATE story_scenes
SET content = E'「スマホでもパソコンでもきれいに見せたいよね」\n\n「Viewport（ビューポート）は、ブラウザの表示領域のこと」\n\n「Media query（メディアクエリ）を使うんだ」\n\n「Mobile-first（モバイルファースト）は、まずスマホ向けに作って、大きい画面向けに拡張する考え方」\n\n「Responsive mode（レスポンシブモード）は、ブラウザでいろんな画面サイズをシミュレーションする機能だよ」'
WHERE id = '950c10f4-46bd-4568-ac68-5e30c1dc1e08';

UPDATE story_scenes
SET content = E'「Semantic HTML（セマンティックHTML）を心がけてな」とHTMLくん。\n\n「<div> ばかり使わずに、意味のあるタグを使うんだ」\n\n「Accessibility（アクセシビリティ）——誰でも使えるサイトを目指そう」\n\n「ARIA（エリア）属性は、目の見えない人が使うスクリーンリーダーに情報を伝えるための属性なんだ」'
WHERE id = '0b424c5e-56b5-441f-a55f-fa5c9903ef84';

UPDATE story_scenes
SET content = E'「他のサイトの内容を埋め込むこともできるよ」\n\n「iFrame（アイフレーム）は、別のページを枠の中に表示する方法」\n\n「Embed code（埋め込みコード）は、YouTubeやGoogleマップなどを自分のサイトに貼り付けるコード」\n\n「Container（コンテナ）と Wrapper（ラッパー）は、要素をまとめて囲む箱だよ。レイアウトを整えるのに使うんだ」\n\n「Pseudo-class（擬似クラス）は :hover など、状態を表すセレクタ」\n\n「Pseudo-element（擬似要素）は ::before など、要素の一部を装飾するセレクタ」'
WHERE id = 'fa738bdf-40ff-49a2-99c3-23bb0e028d85';