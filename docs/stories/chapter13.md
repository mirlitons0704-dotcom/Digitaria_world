# 第13章：パッケージ配送センター

**〜 便利な道具を届けます 〜**

**カテゴリ：環境＆パッケージ管理**
**登場用語：Development environment, Production environment, Staging environment, Preview environment, Environment variable, npm, npm package, npm install, npm run, npx, Yarn, Package, Packages, Dependency, Dev dependency, Package.json, Package-lock.json, Node modules, Semantic versioning, Lock file**

---

## シーン1：配送センター

```
洞窟を抜けると、
巨大な配送センターがあった。

たくさんのトラックが行き来している。

「やあ！僕はパッケージ配達員。
世界中の開発者に
便利なパッケージを届けているんだ」

「Package（パッケージ）は、
誰かが作った便利なコードの塊。
自分で一から作らなくても、
パッケージを使えば時間短縮になるよ」
```

---

## シーン2：npm の世界

```
「npm（エヌピーエム）は、
Node Package Manager の略。
JavaScript のパッケージ管理ツールだよ」

「npm package（npmパッケージ）は、
npm で配布されているパッケージのこと」

「npm install（インストール）は、
パッケージをダウンロードするコマンド」

$ npm install react
$ npm install lodash

「npm run は、
スクリプトを実行するコマンド」

$ npm run dev      # 開発サーバー起動
$ npm run build    # 本番用にビルド

「npx は、
パッケージをインストールせずに
一時的に実行するコマンドだよ」

$ npx create-react-app my-app
```

**💡 用語登場：npm, npm package, npm install, npm run, npx**

---

## シーン3：Yarn と選択肢

```
「Yarn（ヤーン）も
人気のあるパッケージマネージャーだよ」

「npm と同じことができるけど、
少しコマンドが違う」

npm install  →  yarn add
npm run dev  →  yarn dev

「どちらを使うかはチームで決めるけど、
機能的にはほぼ同じだよ」

「Packages（パッケージズ）は、
パッケージの複数形。
プロジェクトで使う
たくさんのパッケージを指すね」
```

**💡 用語登場：Yarn, Packages**

---

## シーン4：依存関係

```
「Dependency（依存関係）は、
プロジェクトが必要とするパッケージのこと」

「React を使うプロジェクトなら、
React がプロジェクトの依存関係だね」

「Dev dependency（開発依存）は、
開発時だけ必要なパッケージ」

「テストツールや、
コード整形ツールなどがこれに当たる」

$ npm install jest --save-dev

「--save-dev をつけると、
開発依存としてインストールされるよ」
```

**💡 用語登場：Dependency, Dev dependency, Package**

---

## シーン5：設定ファイル

```
「Package.json（パッケージジェイソン）は、
プロジェクトの設定ファイルだよ」

{
  "name": "my-project",
  "version": "1.0.0",
  "dependencies": {
    "react": "^18.2.0"
  },
  "devDependencies": {
    "jest": "^29.0.0"
  },
  "scripts": {
    "dev": "next dev",
    "build": "next build"
  }
}

「どんなパッケージを使っているか、
どんなスクリプトがあるか、
全部ここに書いてあるんだ」

「Package-lock.json は
Lock file（ロックファイル）の一種。
正確なバージョンを固定するよ」

「Node modules（ノードモジュールズ）は、
インストールしたパッケージが
入っているフォルダだよ」
```

**💡 用語登場：Package.json, Package-lock.json, Lock file, Node modules**

---

## シーン6：バージョン管理

```
「Semantic versioning（セマンティックバージョニング）は、
バージョン番号の付け方のルールだよ」

    1.2.3
    ↑ ↑ ↑
    │ │ └─ パッチ（バグ修正）
    │ └─── マイナー（機能追加、互換性あり）
    └───── メジャー（大きな変更、互換性なし）

「^18.2.0 の ^ は、
マイナーバージョンまでの更新を許可する記号」

「~18.2.0 の ~ は、
パッチバージョンの更新だけ許可」

「バージョンを固定しないと、
『昨日は動いたのに今日は動かない！』
なんてことが起きるんだ」
```

**💡 用語登場：Semantic versioning**

---

## シーン7：環境の種類

```
「開発には複数の『環境』があるよ」

「Development environment（開発環境）は、
開発者がコードを書いて試す環境」

「Staging environment（ステージング環境）は、
本番に近い状態でテストする環境」

「Preview environment（プレビュー環境）は、
変更をレビューするための一時的な環境」

「Production environment（本番環境）は、
実際にユーザーが使う環境」

開発 → ステージング → 本番
        ↑
      ここでテスト

「Environment variable（環境変数）は、
環境ごとに異なる設定値を
外部から渡す仕組みだよ」

「API キーやデータベースの接続先を
環境ごとに変えられるんだ」
```

**💡 用語登場：Development environment, Staging environment, Preview environment, Production environment, Environment variable**

---

## 第13章クリア！

```
🎉 おめでとう！第13章をクリアしました！

【習得した用語】20語
✅ npm, npm package, npm install, npm run, npx, Yarn
✅ Package, Packages, Dependency, Dev dependency
✅ Package.json, Package-lock.json, Node modules
✅ Semantic versioning, Lock file
✅ Development environment, Production environment
✅ Staging environment, Preview environment, Environment variable

【次の冒険へ】
第14章「時の図書館」が解放されました！
Git とバージョン管理を学びましょう。
```

---
