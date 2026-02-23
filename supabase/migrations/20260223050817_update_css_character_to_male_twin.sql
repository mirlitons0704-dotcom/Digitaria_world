/*
  # Update CSS character to male twin

  1. Character Changes
    - `CSSちゃん` renamed to `CSSくん`
    - Role changed from タグ兄弟（妹）to タグ双子（弟）
    - Speech style changed from feminine to masculine
    - HTMLくん role updated to タグ双子（兄）

  2. Story Scene Changes
    - Scene 1 (ch5): 「私はCSS」→「僕はCSS」, feminine endings → masculine
    - Scene 3 (ch5): CSSちゃん→CSSくん, all feminine speech → masculine

  3. Notes
    - HTML and CSS are now male twins instead of brother/sister
*/

UPDATE characters
SET
  name = 'CSSくん',
  name_en = 'CSS-kun',
  role = 'タグ双子（弟）',
  personality = '美的センスがあり装飾好き',
  speech_style = '〜だよ、〜なんだ'
WHERE id = '77777777-7777-7777-7777-777777777777';

UPDATE characters
SET role = 'タグ双子（兄）'
WHERE id = '66666666-6666-6666-6666-666666666666';

UPDATE story_scenes
SET content = E'道場を出ると、にぎやかな建設現場に着いた。あちこちで建物が作られている。\n\n「ここは Web ページ建設現場だよ！」\n\n双子が近づいてきた。\n\n{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/illustrations/ch5_s1_inline2_1771822286683.png}}\n\n「やあ！僕は HTML（エイチティーエムエル）」\n「僕は CSS（シーエスエス）」\n\n「二人で協力して、Web ページという『家』を建てているんだ」\n\n「HTML が家の構造——柱や壁を担当」\n「CSS が内装——色や配置を担当」\n\n「二人セットで、初めて素敵な家になるんだ」'
WHERE id = 'd856c36c-3f0a-4c21-92bc-f098d2d57b50';

UPDATE story_scenes
SET content = E'「要素には名前をつけられるんだ」と CSS くん。\n\n「Class（クラス）は、複数の要素に同じ名前をつけるとき」\n\n「ID は、たった一つの要素につける固有の名前だよ」\n\n「Selector（セレクタ）は、どの要素にスタイルを適用するか選ぶ方法」\n\n「Property（プロパティ）と Value（値）でスタイルを指定するんだ」'
WHERE id = '9194c335-032b-488e-b1a4-42d89759ee3c';