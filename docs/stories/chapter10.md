# 第10章：デザインの美術館

**〜 美しく、使いやすく 〜**

**カテゴリ：UI/UX & デザイン**
**登場用語：UI/UX, User interface, User experience, Wireframe, Mockup, Design system, Component library, Design tokens, Theme, Light mode, Dark mode, Color scheme, Hex color, RGB, Opacity, Font, Typography, Font family, Font weight, Font size, Line height, Google Fonts, Icon, Lucide dev icons, Favicon, Hover state, Active state, Focus state, Disabled state, Drop shadow, Border radius, Gradient, Animations, Transition, Pexels, More options icon, Row, Column, Home, QR code**

---

## シーン1：美術館への招待

```
工房を出ると、
白い大理石の建物が見えてきた。

「ここは『デザインの美術館』よ」
ミアさんが案内してくれた。

「この章では UI/UX について学ぶわ」

「UI は User interface（ユーザーインターフェース）——
ユーザーが触れる画面や部品のこと」

「UX は User experience（ユーザーエクスペリエンス）——
ユーザーが感じる体験全体のこと」

「見た目の美しさ（UI）と、
使いやすさ（UX）の両方が
大切なの」
```

**💡 用語登場：UI/UX, User interface, User experience**

---

## シーン2：設計の工程

```
最初の展示室には、設計図が並んでいた。

「Wireframe（ワイヤーフレーム）は、
ページの骨組みだけを描いた設計図」

「色やデザインは省いて、
配置だけを考えるの」

┌─────────────────────┐
│ [ロゴ]     [メニュー]│
├─────────────────────┤
│                      │
│   [メイン画像]       │
│                      │
├──────────┬──────────┤
│ [カード] │ [カード] │
└──────────┴──────────┘

「Mockup（モックアップ）は、
色やフォントを入れた
完成イメージに近いデザイン」

「ワイヤーフレーム → モックアップ → 実装
という流れで進めることが多いわ」
```

**💡 用語登場：Wireframe, Mockup**

---

## シーン3：デザインシステム

```
「Design system（デザインシステム）は、
デザインのルールをまとめたもの」

「色、フォント、余白、ボタンのスタイル……
すべて統一することで、
ブランドの一貫性を保てるの」

「Component library（コンポーネントライブラリ）は、
再利用できる部品の集まり」

「Design tokens（デザイントークン）は、
色やサイズを変数として定義したもの」

--primary-color: #3B82F6;
--spacing-md: 16px;
--font-size-lg: 18px;

「Theme（テーマ）は、
デザインの全体的な雰囲気のこと」

「Light mode（ライトモード）は明るい背景、
Dark mode（ダークモード）は暗い背景。
最近は両方用意するのが主流ね」
```

**💡 用語登場：Design system, Component library, Design tokens, Theme, Light mode, Dark mode**

---

## シーン4：色の世界

```
次の展示室は、虹のような色彩に満ちていた。

「Color scheme（カラースキーム）は、
サイト全体の配色計画よ」

「色の指定方法はいくつかあるの」

「Hex color（16進数カラー）は
# から始まる6桁の英数字」

#FF5733  ← オレンジ系の色

「RGB は赤・緑・青の
3つの値で色を表す」

rgb(255, 87, 51)  ← 同じ色

「Opacity（オパシティ）は透明度。
0が完全に透明、1が完全に不透明」

rgba(255, 87, 51, 0.5)  ← 半透明
```

**💡 用語登場：Color scheme, Hex color, RGB, Opacity**

---

## シーン5：文字の美しさ

```
「Typography（タイポグラフィ）は、
文字のデザインを扱う分野よ」

「Font（フォント）は書体のこと」

「Font family（フォントファミリー）は、
使用するフォントの指定」

font-family: "Noto Sans JP", sans-serif;

「Font size（フォントサイズ）は文字の大きさ、
Font weight（フォントウェイト）は太さ」

font-size: 16px;
font-weight: bold;  /* または 700 */

「Line height（ラインハイト）は行の高さ。
1.5〜1.8くらいが読みやすいわ」

「Google Fonts は、
無料で使えるフォントの宝庫よ。
Web サイトで簡単に使えるの」
```

**💡 用語登場：Typography, Font, Font family, Font size, Font weight, Line height, Google Fonts**

---

## シーン6：アイコンと画像

```
「Icon（アイコン）は、
意味を伝える小さな絵よ」

🏠 ホーム  📧 メール  ⚙️ 設定

「Lucide dev icons は、
人気のあるアイコンライブラリ」

「Favicon（ファビコン）は、
ブラウザのタブに表示される
小さなアイコン」

「Pexels は、
無料で商用利用できる
写真素材サイトよ」

「More options icon（もっと見るアイコン）は、
⋮ や … のようなメニューを開くアイコン」

「Home（ホーム）は、
サイトのトップページを指すわ。
🏠アイコンで表すことが多いわね」

「QR code（QRコード）は、
スマホで読み取ると
URLなどに飛べる四角いコードよ」
```

**💡 用語登場：Icon, Lucide dev icons, Favicon, Pexels, More options icon, Home, QR code**

---

## シーン7：状態のデザイン

```
「部品には様々な『状態』があるの」

「Hover state（ホバー状態）は、
マウスを乗せたときの見た目」

「Active state（アクティブ状態）は、
クリック中の見た目」

「Focus state（フォーカス状態）は、
キーボードで選択したときの見た目。
アクセシビリティに重要よ」

「Disabled state（無効状態）は、
操作できないときの見た目。
グレーアウトすることが多いわ」

┌─────────────────────────────┐
│ 通常    ホバー   アクティブ  無効  │
│ [送信]  [送信]    [送信]   [送信]│
│  青      濃い青   もっと濃い  灰色 │
└─────────────────────────────┘
```

**💡 用語登場：Hover state, Active state, Focus state, Disabled state**

---

## シーン8：装飾と効果

```
「デザインを豊かにする装飾テクニックよ」

「Drop shadow（ドロップシャドウ）は、
要素に影をつけて浮いているように見せる」

box-shadow: 0 4px 6px rgba(0,0,0,0.1);

「Border radius（ボーダーラディウス）は、
角を丸くする設定」

border-radius: 8px;   /* 少し丸く */
border-radius: 50%;   /* 完全な円 */

「Gradient（グラデーション）は、
色が徐々に変化する効果」

background: linear-gradient(to right, blue, purple);

「これらを組み合わせると、
立体感や奥行きが生まれるの」
```

**💡 用語登場：Drop shadow, Border radius, Gradient**

---

## シーン9：動きの魔法

```
「Animations（アニメーション）は、
要素に動きをつけること」

「Transition（トランジション）は、
状態が変わるときの滑らかな変化」

transition: all 0.3s ease;

「ホバーしたとき、ふわっと色が変わる——
そんな心地よい動きを作れるわ」

「でも、やりすぎは禁物よ。
動きが多すぎると疲れるし、
酔う人もいるの」

「アニメーションは
『スパイス』のようなもの。
適量が大切ね」
```

**💡 用語登場：Animations, Transition**

---

## シーン10：レイアウトの基本

```
「最後に、レイアウトの基本用語を」

「Row（ロウ）は横の行、
Column（コラム）は縦の列」

    Column Column Column
       ↓     ↓     ↓
Row → [  ] [  ] [  ]
Row → [  ] [  ] [  ]
Row → [  ] [  ] [  ]

「グリッドシステムでは、
この行と列を組み合わせて
レイアウトを作るの」

「デザインの基本を学んだわね。
次は、CSS フレームワークで
効率よくスタイリングする方法を学びましょう」
```

**💡 用語登場：Row, Column**

---

## 第10章クリア！

```
🎉 おめでとう！第10章をクリアしました！

【習得した用語】40語
✅ UI/UX, User interface, User experience
✅ Wireframe, Mockup, Design system, Component library, Design tokens
✅ Theme, Light mode, Dark mode, Color scheme, Hex color, RGB, Opacity
✅ Font, Typography, Font family, Font weight, Font size, Line height, Google Fonts
✅ Icon, Lucide dev icons, Favicon, Pexels, More options icon, Home, QR code
✅ Hover state, Active state, Focus state, Disabled state
✅ Drop shadow, Border radius, Gradient, Animations, Transition
✅ Row, Column

【次の冒険へ】
第11章「スタイルの仕立て屋」が解放されました！
CSSフレームワークで効率よくスタイリングしましょう。
```

---
