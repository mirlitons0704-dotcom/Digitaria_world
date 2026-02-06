# 第15章：サーバーの城

**〜 裏側で支える力 〜**

**カテゴリ：バックエンド＆サーバーサイド**
**登場用語：Backend, Back end, Server, Server side, Client side, Frontend, Front end, Full stack, Endpoint, Route, Routes, Route security, Router, Controller, Model, Middleware, Handler, Service, Business logic, REST, RESTful, Stateless, Session, Cookie, Header, Body, Payload, GET, POST, PUT**

---

## シーン1：城への到着

```
時の図書館を出ると、
堂々たる城がそびえていた。

「サーバーの城へようこそ！」

鎧を着た騎士が出迎えた。

「私はサーバー守護者。
この城——Backend（バックエンド）を守っている」

「Backend、または Back end は、
ユーザーから見えない裏側の処理を担当する」

「Server（サーバー）は、
リクエストを受け取って
処理を行うコンピュータだ」

「Server side（サーバーサイド）は、
サーバーで実行される処理のこと」
```

**💡 用語登場：Backend, Back end, Server, Server side**

---

## シーン2：表と裏

```
「対になる概念を説明しよう」

「Frontend / Front end（フロントエンド）は、
ユーザーが直接触れる画面側」

「Client side（クライアントサイド）は、
ユーザーのブラウザで実行される処理」

      ユーザー
         │
         ↓
  ┌─────────────┐
  │  Frontend   │ ← ブラウザで動く
  │ (Client)    │
  └──────┬──────┘
         │ リクエスト
         ↓
  ┌─────────────┐
  │  Backend    │ ← サーバーで動く
  │ (Server)    │
  └─────────────┘

「Full stack（フルスタック）は、
両方できる開発者のことだ」
```

**💡 用語登場：Frontend, Front end, Client side, Full stack**

---

## シーン3：ルーティング

```
「城には様々な部屋がある。
どの部屋に案内するか決めるのが
Route（ルート）だ」

「Routes は複数のルート。
Endpoint（エンドポイント）とも呼ばれる」

GET  /users      → ユーザー一覧
GET  /users/123  → ID:123のユーザー
POST /users      → 新規ユーザー作成

「Router（ルーター）は、
リクエストを適切なルートに
振り分ける仕組み」

「Route security（ルートセキュリティ）は、
認証されたユーザーだけが
アクセスできるようにする保護だ」
```

**💡 用語登場：Route, Routes, Endpoint, Router, Route security**

---

## シーン4：処理の流れ

```
「リクエストがどう処理されるか説明しよう」

「Controller（コントローラー）は、
リクエストを受け取って
処理を振り分ける司令塔」

「Service（サービス）は、
Business logic（ビジネスロジック）——
実際の処理を行う部分」

「Model（モデル）は、
データの形を定義し、
データベースとやり取りする」

「Handler（ハンドラー）は、
特定の処理を担当する関数」

リクエスト
    ↓
Controller（受付）
    ↓
Service（処理）
    ↓
Model（データ操作）
    ↓
レスポンス
```

**💡 用語登場：Controller, Service, Business logic, Model, Handler**

---

## シーン5：ミドルウェア

```
「Middleware（ミドルウェア）は、
リクエストとレスポンスの間に挟まる処理だ」

「認証チェック、ログ記録、
データの変換などを行う」

リクエスト
    ↓
[認証ミドルウェア] ← ログインしてる？
    ↓
[ログミドルウェア] ← 記録しておこう
    ↓
Controller
    ↓
レスポンス

「玄関で身分証を確認する
警備員のようなものだ」
```

**💡 用語登場：Middleware**

---

## シーン6：REST API

```
「REST（レスト）は、
API の設計スタイルだ」

「RESTful（レストフル）は、
REST の原則に従っていること」

「Stateless（ステートレス）は、
サーバーがクライアントの状態を
覚えていないこと」

「毎回、必要な情報を
リクエストに含めて送る」

「Session（セッション）は、
ユーザーの状態を一時的に保存する仕組み」

「Cookie（クッキー）は、
ブラウザに保存される小さなデータ。
ログイン状態の維持などに使う」
```

**💡 用語登場：REST, RESTful, Stateless, Session, Cookie**

---

## シーン7：リクエストの中身

```
「リクエストの構造を見てみよう」

「Header（ヘッダー）は、
リクエストの付加情報」

Content-Type: application/json
Authorization: Bearer xxx...

「Body（ボディ）は、
リクエストの本文——送るデータ」

「Payload（ペイロード）も
Body と同じ意味で使われる」

{
  "name": "ビットくん",
  "email": "bit@example.com"
}

「GET リクエストには Body がない。
POST、PUT には Body がある」
```

**💡 用語登場：Header, Body, Payload**

---

## シーン8：HTTPメソッド

```
「HTTP メソッドは、
何をしたいかを示す」

「GET は『取得したい』」
「POST は『新しく作りたい』」
「PUT は『更新したい』」

GET    /users      ユーザー一覧を取得
POST   /users      ユーザーを新規作成
PUT    /users/123  ユーザー123を更新

「これらを正しく使い分けることが、
RESTful な API 設計の基本だ」

「次の章では、
API についてもっと詳しく学ぼう」
```

**💡 用語登場：GET, POST, PUT**

---

## 第15章クリア！

```
🎉 おめでとう！第15章をクリアしました！

【習得した用語】30語
✅ Backend, Back end, Server, Server side, Client side
✅ Frontend, Front end, Full stack
✅ Endpoint, Route, Routes, Route security, Router
✅ Controller, Model, Middleware, Handler, Service, Business logic
✅ REST, RESTful, Stateless, Session, Cookie
✅ Header, Body, Payload, GET, POST, PUT

【次の冒険へ】
第16章「APIの大使館」が解放されました！
最後の冒険——APIの世界を学びましょう。
```

---
