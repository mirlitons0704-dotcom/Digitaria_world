# 第11章：スタイルの仕立て屋

**〜 効率よく美しく 〜**

**カテゴリ：CSSフレームワーク＆スタイリング**
**登場用語：Tailwind, Utility-first, Shadcn, CSS-in-JS, CSS modules, SCSS, Sass, CSS variables, Custom properties, Scoped styles, Global styles, Reset CSS, Normalize CSS, PostCSS, Autoprefixer**

---

## シーン1：仕立て屋の店

```
美術館を出ると、
おしゃれな仕立て屋の店が見えた。

「いらっしゃい！
私はテイル職人。
CSSを効率よく書く技術を教えるよ」

「CSS は自由度が高い分、
大きなプロジェクトでは
管理が大変になるんだ」

「そこで登場するのが
CSS フレームワークや
様々なスタイリング手法さ」
```

---

## シーン2：Tailwind CSS

```
「Tailwind（テイルウィンド）は、
今最も人気のある CSS フレームワークだ」

「Utility-first（ユーティリティファースト）
という考え方に基づいている」

「小さなクラスを組み合わせて
スタイルを作るんだ」

<button class="bg-blue-500 text-white px-4 py-2 rounded">
  送信
</button>

「bg-blue-500 は背景色、
text-white は文字色、
px-4 は左右のパディング、
py-2 は上下のパディング、
rounded は角丸」

「CSS ファイルを別に書かなくても、
HTML の中でスタイリングが完結する」

「慣れると爆速で開発できるよ！」
```

**💡 用語登場：Tailwind, Utility-first**

---

## シーン3：コンポーネントライブラリ

```
「Shadcn（シャドシーエヌ）は、
Tailwind ベースの
美しいコンポーネント集だ」

「コピー&ペーストで使えて、
カスタマイズも自由自在」

「既製品をそのまま使うんじゃなく、
自分のプロジェクトに
取り込んで改造できるのが特徴さ」

「CSS-in-JS（シーエスエス・イン・ジェイエス）は、
JavaScript の中に CSS を書く手法」

const Button = styled.button`
  background: blue;
  color: white;
  padding: 8px 16px;
`;

「CSS modules（CSSモジュール）は、
CSS をコンポーネントごとに
分離して管理する仕組みだ」
```

**💡 用語登場：Shadcn, CSS-in-JS, CSS modules**

---

## シーン4：Sass と SCSS

```
「Sass（サス）と SCSS（エスシーエスエス）は、
CSS を拡張した言語だ」

「変数、ネスト、ミックスイン……
CSS にはない便利な機能が使える」

// SCSS の例
$primary-color: #3B82F6;

.card {
  background: white;

  .title {
    color: $primary-color;  // 変数が使える
  }

  &:hover {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }
}

「ネスト（入れ子）で書けるから、
構造がわかりやすいだろう？」

「ただし、ブラウザは SCSS を
直接理解できないから、
CSS に変換（コンパイル）する必要があるんだ」
```

**💡 用語登場：Sass, SCSS**

---

## シーン5：CSS 変数

```
「CSS variables（CSS変数）は、
CSS 自体が持つ変数機能だ」

「Custom properties（カスタムプロパティ）
とも呼ばれる」

:root {
  --primary-color: #3B82F6;
  --spacing-md: 16px;
}

.button {
  background: var(--primary-color);
  padding: var(--spacing-md);
}

「-- から始まる名前で定義して、
var() で使用する」

「テーマの切り替えにも便利だ。
変数の値を変えるだけで、
サイト全体の色が変わるからね」
```

**💡 用語登場：CSS variables, Custom properties**

---

## シーン6：スタイルのスコープ

```
「スタイルの適用範囲も重要だ」

「Global styles（グローバルスタイル）は、
サイト全体に適用されるスタイル」

「Scoped styles（スコープドスタイル）は、
特定のコンポーネントだけに
適用されるスタイル」

「スコープを分けないと、
意図しない場所にスタイルが
漏れ出してしまうんだ」

「『このボタンを青くしたら、
別のページのボタンも青くなった！』
なんてことが起きる」

「だから、コンポーネントごとに
スタイルを閉じ込めるのが大切さ」
```

**💡 用語登場：Global styles, Scoped styles**

---

## シーン7：リセットと正規化

```
「ブラウザにはデフォルトのスタイルがある。
でも、ブラウザごとに微妙に違うんだ」

「Reset CSS（リセットCSS）は、
すべてのデフォルトスタイルを
ゼロにリセットする手法」

「Normalize CSS（ノーマライズCSS）は、
ブラウザ間の違いを揃えつつ、
便利なデフォルトは残す手法」

「どちらを使うかは好みだけど、
何かしらの対策は必要だ」

「そうしないと、
『自分のパソコンでは綺麗なのに、
友達のパソコンでは崩れている！』
なんてことになる」
```

**💡 用語登場：Reset CSS, Normalize CSS**

---

## シーン8：ビルドツール

```
「PostCSS（ポストシーエスエス）は、
CSS を変換・最適化するツールだ」

「プラグインを組み合わせて、
様々な処理ができる」

「Autoprefixer（オートプレフィクサー）は、
ブラウザ対応のための
接頭辞を自動で追加してくれる」

/* 書いたコード */
display: flex;

/* Autoprefixer が自動で追加 */
display: -webkit-flex;
display: -ms-flexbox;
display: flex;

「古いブラウザへの対応を
自動でやってくれるから、
開発者は楽ができるんだ」
```

**💡 用語登場：PostCSS, Autoprefixer**

---

## 第11章クリア！

```
🎉 おめでとう！第11章をクリアしました！

【習得した用語】15語
✅ Tailwind, Utility-first, Shadcn
✅ CSS-in-JS, CSS modules, SCSS, Sass
✅ CSS variables, Custom properties
✅ Scoped styles, Global styles
✅ Reset CSS, Normalize CSS, PostCSS, Autoprefixer

【次の冒険へ】
第12章「ターミナルの洞窟」が解放されました！
コマンドラインの使い方を学びましょう。
```

---
