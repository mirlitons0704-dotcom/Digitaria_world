# 第14章：時の図書館

**〜 歴史を記録し、時を戻す 〜**

**カテゴリ：バージョン管理＆Git**
**登場用語：Git, GitHub, Repository, Clone, Fork, Branch, Main branch, Feature branch, Checkout, Commit, Commit/push/pull, Push, Pull, Merge, Merge conflict, Rebase, Stash, Reset, Revert, Diff, Staging area, .gitignore, Pull request, Code review, GitHub Actions**

---

## シーン1：時の図書館

```
配送センターを出ると、
古めかしい図書館が現れた。

でも中に入ると、
無数の光る線が時間軸のように浮かんでいた。

「ようこそ、時の図書館へ。
私はギット管理人」

「ここでは、コードの『歴史』を
記録し、管理する方法を教えよう」

「Git（ギット）は、
バージョン管理システム——
コードの変更履歴を
記録・管理するツールだ」
```

**💡 用語登場：Git**

---

## シーン2：リポジトリ

```
「Repository（リポジトリ）は、
プロジェクトの保管庫だ。
コードと、その全履歴が入っている」

「GitHub（ギットハブ）は、
リポジトリをオンラインで
共有・管理するサービスだ」

「Clone（クローン）は、
リポジトリを自分のパソコンに
コピーすること」

$ git clone https://github.com/user/repo.git

「Fork（フォーク）は、
他人のリポジトリを
自分のアカウントにコピーすること」

「クローンは『借りる』、
フォークは『自分のものにする』
というイメージだ」
```

**💡 用語登場：Repository, GitHub, Clone, Fork**

---

## シーン3：ブランチ

```
「Branch（ブランチ）は、
開発の『枝分かれ』だ」

光る線が枝分かれしている様子が見えた。

「Main branch（メインブランチ）は、
本流——本番環境のコードだ」

「Feature branch（フィーチャーブランチ）は、
新機能を開発するための枝」

main ─────●─────●─────●─────
           \           /
feature     ●─────●───●

「枝分かれして開発し、
完成したら本流に戻す」

「Checkout（チェックアウト）は、
ブランチを切り替えること」

$ git checkout feature-login
$ git checkout -b new-branch  # 新しいブランチを作成
```

**💡 用語登場：Branch, Main branch, Feature branch, Checkout**

---

## シーン4：コミット

```
「Commit（コミット）は、
変更を記録する行為だ」

「セーブポイントを作るようなもの」

$ git add .
$ git commit -m "ログイン機能を追加"

「Staging area（ステージングエリア）は、
コミットする前の『準備エリア』」

「git add で変更をステージに上げ、
git commit で確定する」

「コミットメッセージは
何を変更したか簡潔に書くこと」

✅ 良い例: "ログインフォームのバリデーションを追加"
❌ 悪い例: "修正" "更新" "あああ"
```

**💡 用語登場：Commit, Staging area**

---

## シーン5：プッシュとプル

```
「Commit/push/pull は、
Git の基本的な流れだ」

「Push（プッシュ）は、
ローカルの変更を
リモート（GitHub）に送ること」

$ git push origin main

「Pull（プル）は、
リモートの変更を
ローカルに取り込むこと」

$ git pull origin main

「チームで開発するときは、
まず Pull して最新を取得、
作業して Commit、
最後に Push する」

Pull → 作業 → Commit → Push
```

**💡 用語登場：Commit/push/pull, Push, Pull**

---

## シーン6：マージ

```
「Merge（マージ）は、
ブランチを統合すること」

$ git checkout main
$ git merge feature-login

main ─────●─────●─────●──────●
           \           /
feature     ●─────●───●

「Merge conflict（マージコンフリクト）は、
同じ場所を別々に編集したとき起きる衝突」

<<<<<<< HEAD
const color = "blue";
=======
const color = "red";
>>>>>>> feature

「どちらを採用するか、
手動で解決する必要がある」

「Rebase（リベース）は、
ブランチの起点を移動させる
別のマージ方法だ」
```

**💡 用語登場：Merge, Merge conflict, Rebase**

---

## シーン7：便利なコマンド

```
「他にも便利なコマンドがある」

「Stash（スタッシュ）は、
作業中の変更を一時的に退避」

$ git stash      # 退避
$ git stash pop  # 復元

「Reset（リセット）は、
コミットを取り消す」

「Revert（リバート）は、
コミットを打ち消す新しいコミットを作る」

「Diff（ディフ）は、
変更点を確認するコマンド」

$ git diff

「.gitignore（ギットイグノア）は、
Git で追跡しないファイルを指定する」

# .gitignore の例
node_modules/
.env
*.log
```

**💡 用語登場：Stash, Reset, Revert, Diff, .gitignore**

---

## シーン8：プルリクエスト

```
「Pull request（プルリクエスト）は、
変更を本流に取り込んでもらう
『お願い』だ」

「GitHub 上で作成する」

「Code review（コードレビュー）は、
他の人がコードをチェックすること」

「レビューで承認されたら、
マージされる」

Feature branch
      │
      ↓ Pull Request
      │
      ↓ Code Review
      │
      ↓ Approve（承認）
      │
      ↓ Merge
Main branch

「GitHub Actions（ギットハブアクションズ）は、
プッシュやプルリクエストをきっかけに
自動でテストやデプロイを実行する仕組みだ」
```

**💡 用語登場：Pull request, Code review, GitHub Actions**

---

## 第14章クリア！

```
🎉 おめでとう！第14章をクリアしました！

【習得した用語】25語
✅ Git, GitHub, Repository, Clone, Fork
✅ Branch, Main branch, Feature branch, Checkout
✅ Commit, Commit/push/pull, Push, Pull
✅ Merge, Merge conflict, Rebase
✅ Stash, Reset, Revert, Diff, Staging area, .gitignore
✅ Pull request, Code review, GitHub Actions

【次の冒険へ】
第15章「サーバーの城」が解放されました！
バックエンドの世界を学びましょう。
```

---
