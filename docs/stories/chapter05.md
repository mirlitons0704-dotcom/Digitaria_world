# 第5章：Webページ建設現場

**〜 家を建てるように、ページを作る 〜**

**カテゴリ：Web基礎 - HTML & CSS**
**登場用語：HTML, CSS, DOM, Element, Tag, Attribute, Class, ID, Selector, Property, Value, Style, Stylesheet, Inline style, Box model, Margin, Padding, Border, Display, Position, Flexbox, Grid, Z-index, Overflow, Viewport, Responsive design, Responsive mode, Media query, Mobile-first, Semantic HTML, Accessibility, ARIA, Embed code, iFrame, Container, Wrapper, Float, Clear, Pseudo-class, Pseudo-element**

---

## シーン1：建設現場へ

```
道場を出ると、にぎやかな建設現場に着いた。
あちこちで建物が作られている。

「ここは Web ページ建設現場だよ！」

双子が近づいてきた。

「やあ！僕は HTML（エイチティーエムエル）」
「私は CSS（シーエスエス）」

「二人で協力して、
Web ページという『家』を建てているの」

「HTML が家の構造——柱や壁を担当」
「CSS が内装——色や配置を担当」

「二人セットで、初めて素敵な家になるんだ」
```

**💡 用語登場：HTML, CSS**

---

## シーン2：HTMLの骨組み

```
HTML くんが設計図を見せてくれた。

「HTML は Tag（タグ）を使って構造を作るんだ」

<div>
  <h1>ようこそ</h1>
  <p>これは段落です</p>
</div>

「< > で囲んだものがタグ。
<開始タグ>内容</終了タグ> という形だよ」

「Element（要素）は、
タグと中身を合わせた全体のこと」

「Attribute（属性）は、
タグに追加の情報を付けるもの」

<a href="https://example.com">リンク</a>
   └──属性──────────────┘

「DOM（Document Object Model）は、
HTML をツリー構造で表したもの。
JavaScript からページを操作するときに使うよ」
```

**💡 用語登場：Tag, Element, Attribute, DOM**

---

## シーン3：名前をつける

```
「要素には名前をつけられるの」と CSS ちゃん。

「Class（クラス）は、
複数の要素に同じ名前をつけるとき」

<div class="card">カード1</div>
<div class="card">カード2</div>

「ID は、たったひとつの要素につける
固有の名前よ」

<div id="main-header">ヘッダー</div>

「Selector（セレクタ）は、
どの要素にスタイルを適用するか選ぶ方法」

.card { ... }    /* classを選ぶ */
#main-header { ... }  /* IDを選ぶ */
div { ... }      /* タグを選ぶ */

「Property（プロパティ）と Value（値）で
スタイルを指定するの」

color: blue;
└プロパティ┘ └値┘
```

**💡 用語登場：Class, ID, Selector, Property, Value**

---

## シーン4：スタイルの書き方

```
「Style（スタイル）の書き方は3種類あるの」

「Stylesheet（スタイルシート）は、
別ファイルにCSSをまとめる方法。
一番おすすめよ」

<link rel="stylesheet" href="style.css">

「Inline style（インラインスタイル）は、
タグに直接書く方法。
緊急のときだけにしてね」

<p style="color: red;">赤い文字</p>

「整理されたスタイルシートが、
保守しやすいサイトの秘訣よ」
```

**💡 用語登場：Style, Stylesheet, Inline style**

---

## シーン5：箱モデル

```
「すべての要素は『箱』なの」

CSS ちゃんが図を描いた。

「Box model（ボックスモデル）を理解すれば、
レイアウトがわかるわ」

┌─────────── Margin（外側の余白）───────────┐
│ ┌───────── Border（枠線）─────────┐       │
│ │ ┌─────── Padding（内側の余白）─┐│       │
│ │ │      Content（内容）         ││       │
│ │ └────────────────────────────┘│       │
│ └──────────────────────────────┘       │
└──────────────────────────────────────┘

「Margin は要素の外側の余白」
「Padding は要素の内側の余白」
「Border は要素の枠線」

「この3つを調整すれば、
思い通りの配置ができるわ」
```

**💡 用語登場：Box model, Margin, Padding, Border**

---

## シーン6：配置の魔法

```
「Display（表示方法）と Position（位置）で
配置を決めるんだ」とHTMLくん。

「display: block は縦に積み重なる」
「display: inline は横に並ぶ」
「display: none は非表示」

「position: relative は元の位置基準で調整」
「position: absolute は親要素基準で自由配置」
「position: fixed は画面に固定」

「Z-index（Zインデックス）は、
要素の重なり順を決める数値よ」

「数字が大きいほど手前に表示されるの」

「Overflow（オーバーフロー）は、
はみ出した内容をどうするか。
scroll にすればスクロールできるわ」
```

**💡 用語登場：Display, Position, Z-index, Overflow**

---

## シーン7：最新のレイアウト

```
「最近は Flexbox と Grid が主流よ」

「Flexbox（フレックスボックス）は、
1方向の並びが得意。
ナビゲーションやカードの横並びに便利」

display: flex;
justify-content: center;  /* 横方向の配置 */
align-items: center;      /* 縦方向の配置 */

「Grid（グリッド）は、
2方向のレイアウトが得意。
複雑なページ構成に使うわ」

display: grid;
grid-template-columns: 1fr 2fr 1fr;

「昔は Float（フロート）を使っていたけど、
今は Flexbox と Grid の方が便利よ。
Float を使ったら Clear で解除してね」
```

**💡 用語登場：Flexbox, Grid, Float, Clear**

---

## シーン8：レスポンシブデザイン

```
「スマホでもパソコンでもきれいに見せたいよね」

「Viewport（ビューポート）は、
ブラウザの表示領域のこと」

「Responsive design（レスポンシブデザイン）は、
画面サイズに合わせてデザインを変える手法よ」

「Media query（メディアクエリ）を使うの」

@media (max-width: 768px) {
  /* 768px以下のとき適用 */
  .menu { display: none; }
}

「Mobile-first（モバイルファースト）は、
まずスマホ向けに作って、
大きい画面向けに拡張する考え方」

「Responsive mode（レスポンシブモード）は、
ブラウザでいろんな画面サイズを
シミュレーションする機能よ」
```

**💡 用語登場：Viewport, Responsive design, Media query, Mobile-first, Responsive mode**

---

## シーン9：意味のあるHTML

```
「Semantic HTML（セマンティックHTML）を
心がけてね」とHTMLくん。

「<div> ばかり使わずに、
意味のあるタグを使うんだ」

<header>ヘッダー</header>
<nav>ナビゲーション</nav>
<main>メインコンテンツ</main>
<article>記事</article>
<aside>サイドバー</aside>
<footer>フッター</footer>

「Accessibility（アクセシビリティ）——
誰でも使えるサイトを目指そう」

「ARIA（エリア）属性は、
目の見えない人が使うスクリーンリーダーに
情報を伝えるための属性よ」

<button aria-label="メニューを開く">≡</button>
```

**💡 用語登場：Semantic HTML, Accessibility, ARIA**

---

## シーン10：埋め込みと囲み

```
「他のサイトの内容を埋め込むこともできるよ」

「iFrame（アイフレーム）は、
別のページを枠の中に表示する方法」

「Embed code（埋め込みコード）は、
YouTubeやGoogleマップなどを
自分のサイトに貼り付けるコード」

<iframe src="https://www.youtube.com/embed/xxx">
</iframe>

「Container（コンテナ）と Wrapper（ラッパー）は、
要素をまとめて囲む箱よ。
レイアウトを整えるのに使うの」

「Pseudo-class（擬似クラス）は :hover など、
状態を表すセレクタ」

「Pseudo-element（擬似要素）は ::before など、
要素の一部を装飾するセレクタ」

a:hover { color: red; }      /* 擬似クラス */
p::first-letter { font-size: 2em; }  /* 擬似要素 */
```

**💡 用語登場：iFrame, Embed code, Container, Wrapper, Pseudo-class, Pseudo-element**

---

## 第5章クリア！

```
🎉 おめでとう！第5章をクリアしました！

【習得した用語】40語
✅ HTML, CSS, DOM, Element, Tag, Attribute, Class, ID
✅ Selector, Property, Value, Style, Stylesheet, Inline style
✅ Box model, Margin, Padding, Border, Display, Position
✅ Flexbox, Grid, Z-index, Overflow, Viewport
✅ Responsive design, Responsive mode, Media query, Mobile-first
✅ Semantic HTML, Accessibility, ARIA
✅ Embed code, iFrame, Container, Wrapper, Float, Clear
✅ Pseudo-class, Pseudo-element

【次の冒険へ】
第6章「インターネットの海」が解放されました！
URLやHTTPの仕組みを学びましょう。
```

---
