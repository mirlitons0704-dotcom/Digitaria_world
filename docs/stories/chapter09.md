# 第9章：UIパーツ工房（続き）

**〜 使いやすい部品を作る 〜**

**カテゴリ：UIコンポーネント＆パターン**
**登場用語：Page, Component, Layout, Layouts, Card, Button, Input field, Form, Submit, Label, Placeholder, Validation, Error message, Modal, Dialog box, Popup, Overlay, Toast, Notification, Alert, Tooltip, Tool tips, Dropdown menu, Select, Checkbox, Radio button, Toggle, Slider, Progress bar, Spinner, Skeleton loader, Accordion, Tab, Tabs, Pagination, Navigation, Navbar, Sidebar, Footer, Header**

---

## シーン2：ページの構造（続き）

```
「Header（ヘッダー）はページの上部、
Footer（フッター）は下部」

「Navbar（ナビバー）は
ナビゲーションメニュー」

「Sidebar（サイドバー）は
横に配置する補助メニュー」

「Layout（レイアウト）は、
これらの配置パターンのこと。
Layouts で複数のレイアウトを使い分けるわ」

「Navigation（ナビゲーション）は、
ページ間を移動する仕組みね」
```

**💡 用語登場：Page, Layout, Layouts, Header, Footer, Navbar, Sidebar, Navigation**

---

## シーン3：カードとボタン

```
「Card（カード）は、
情報をまとめて表示する箱よ」

ミアさんがサンプルを見せた。

┌────────────────┐
│  🖼️ 画像      │
├────────────────┤
│  タイトル      │
│  説明文...     │
│  [ボタン]      │
└────────────────┘

「SNSの投稿、商品一覧、
プロフィール表示……
カードはどこでも使われるわ」

「Button（ボタン）は、
クリックして何かを実行する部品」

「押せることがひと目でわかる
デザインが大切よ」

<button>送信する</button>
<button disabled>送信できません</button>
```

**💡 用語登場：Card, Button, Component**

---

## シーン4：フォームの部品たち

```
「Form（フォーム）は、
ユーザーが情報を入力する場所よ」

「Input field（入力フィールド）は
テキストを入力する箱」

「Label（ラベル）は、
何を入力するか示すテキスト」

「Placeholder（プレースホルダー）は、
入力欄に薄く表示されるヒント」

<label>メールアドレス</label>
<input placeholder="example@mail.com" />

「Validation（バリデーション）は、
入力内容が正しいかチェックすること」

「Error message（エラーメッセージ）は、
入力に問題があるとき表示する警告」

「Submit（サブミット）は、
フォームの内容を送信すること。
送信ボタンを押すと実行されるわ」
```

**💡 用語登場：Form, Input field, Label, Placeholder, Validation, Error message, Submit**

---

## シーン5：選択する部品たち

```
「選ぶための部品もいろいろあるの」

「Checkbox（チェックボックス）は、
複数選択できる四角いボタン」

☑️ りんご
☑️ みかん
☐ ぶどう

「Radio button（ラジオボタン）は、
ひとつだけ選べる丸いボタン」

◉ 男性
○ 女性
○ その他

「Select（セレクト）は、
ドロップダウンで選ぶ部品」

「Dropdown menu（ドロップダウンメニュー）は、
クリックすると開く選択肢のリスト」

「Toggle（トグル）は、
ON/OFFを切り替えるスイッチ」

「Slider（スライダー）は、
つまみを動かして値を選ぶ部品」

音量: ●━━━━━━━━━○ 80%
```

**💡 用語登場：Checkbox, Radio button, Select, Dropdown menu, Toggle, Slider**

---

## シーン6：お知らせの部品たち

```
「ユーザーに何かを伝える部品も大切よ」

「Alert（アラート）は、
重要なお知らせを目立たせる表示」

⚠️ 保存されていない変更があります

「Notification（通知）は、
新しい情報を知らせる表示」

「Toast（トースト）は、
画面の隅にポッと出てきて
自動で消える短いお知らせ」

「パンがトースターから
ポンと出てくるイメージね」

「Tooltip（ツールチップ）は、
要素にマウスを乗せると出てくる
小さな説明。Tool tips とも呼ぶわ」

[?] ← マウスを乗せると...
      ┌─────────────────┐
      │ここに説明が出る │
      └─────────────────┘
```

**💡 用語登場：Alert, Notification, Toast, Tooltip, Tool tips**

---

## シーン7：重ねて表示する部品

```
「Modal（モーダル）は、
画面の上に重ねて表示するウィンドウ」

「Dialog box（ダイアログボックス）とも呼ぶわ。
確認メッセージや入力フォームに使うの」

「Popup（ポップアップ）も似ているけど、
もっと小さな表示に使うことが多いわ」

「Overlay（オーバーレイ）は、
背景を暗くして
モーダルを目立たせる効果よ」

    ┌─────────────────┐
    │  本当に削除？    │
    │                  │
    │ [キャンセル][OK] │
    └─────────────────┘
  ▓▓▓▓▓（暗い背景）▓▓▓▓▓

「オーバーレイをクリックすると
モーダルが閉じる、という動作も
よく使われるパターンよ」
```

**💡 用語登場：Modal, Dialog box, Popup, Overlay**

---

## シーン8：待機と読み込み

```
「データを読み込んでいる間も、
ユーザーを待たせっぱなしにしないの」

「Spinner（スピナー）は、
くるくる回る読み込み中の表示」

    ⟳ 読み込み中...

「Progress bar（プログレスバー）は、
どれくらい進んだか示すバー」

    ████████░░░░ 67%

「Skeleton loader（スケルトンローダー）は、
コンテンツの形をした
灰色のプレースホルダーよ」

    ┌──────────────────┐
    │ ▓▓▓▓▓▓ （画像）  │
    │ ▓▓▓▓▓▓▓▓▓▓      │
    │ ▓▓▓▓▓▓▓          │
    └──────────────────┘

「何が表示されるかイメージできるから、
待ち時間が短く感じるのよ」
```

**💡 用語登場：Spinner, Progress bar, Skeleton loader**

---

## シーン9：整理する部品たち

```
「情報を整理して表示する部品も紹介するわ」

「Accordion（アコーディオン）は、
クリックすると開閉する折りたたみ式」

▶ セクション1
▼ セクション2
   └─ 展開された内容がここに...
▶ セクション3

「FAQ（よくある質問）でよく使われるわ」

「Tab（タブ）/ Tabs は、
同じ場所で内容を切り替える部品」

┌────┬────┬────┐
│基本│詳細│設定│  ← タブ
├────┴────┴────┤
│    内容...     │
└────────────────┘

「Pagination（ページネーション）は、
コンテンツを複数ページに分けて
ナビゲーションを表示する仕組み」

    < 1  2  [3]  4  5 >
```

**💡 用語登場：Accordion, Tab, Tabs, Pagination**

---

## 第9章クリア！

```
🎉 おめでとう！第9章をクリアしました！

【習得した用語】40語
✅ Page, Component, Layout, Layouts, Card, Button
✅ Input field, Form, Submit, Label, Placeholder
✅ Validation, Error message
✅ Modal, Dialog box, Popup, Overlay
✅ Toast, Notification, Alert, Tooltip, Tool tips
✅ Dropdown menu, Select, Checkbox, Radio button, Toggle, Slider
✅ Progress bar, Spinner, Skeleton loader
✅ Accordion, Tab, Tabs, Pagination
✅ Navigation, Navbar, Sidebar, Footer, Header

【次の冒険へ】
第10章「デザインの美術館」が解放されました！
UI/UXの考え方を学びましょう。
```

---
