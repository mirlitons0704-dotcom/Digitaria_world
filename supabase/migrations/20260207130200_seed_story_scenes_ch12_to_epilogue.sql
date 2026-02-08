/*
  # Seed Story Scenes for Chapters 12-16 + Epilogue

  Chapter 12: ターミナルの洞窟 (7 scenes, guide: ターミナルじいさん)
  Chapter 13: パッケージ配送センター (7 scenes, guide: パッケージ配達員)
  Chapter 14: 時の図書館 (8 scenes, guide: ギット管理人)
  Chapter 15: サーバーの城 (8 scenes, guide: サーバー守護者)
  Chapter 16: APIの大使館 (9 scenes, guide: API大使)
  Chapter 17: エピローグ〜メモリーガーデン〜 (13 scenes, guide: ビットくん & バイトさん)
*/

-- =============================================
-- Chapter 12: ターミナルの洞窟
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (12, 1, '洞窟の入り口',
   E'仕立て屋を出ると、山の中腹に洞窟が見えた。\n\n入り口には長い白髭の老人がいた。\n\n「ようこそ、ターミナルの洞窟へ。わしはターミナルじいさんじゃ」\n\n「この洞窟では、黒い画面——ターミナルの使い方を教えるぞ」\n\n「初心者は黒い画面を怖がるが、使いこなせば最強の武器になる」',
   ARRAY[]::text[],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[]),

  (12, 2, '開発環境',
   E'「まず、開発環境の話からじゃ」\n\n「IDE（アイディーイー）は、Integrated Development Environment——統合開発環境のこと」\n\n「コードを書く、実行する、デバッグする……すべてが一つにまとまったツールじゃ」\n\n「Code editor（コードエディター）は、コードを書くためのエディタ。Visual Studio Code が人気じゃな」\n\n「IDE は機能が豊富、Code editor はシンプルで軽い。それぞれ長所があるんじゃ」\n\n「Sandbox（サンドボックス）は、安全にコードを試せる隔離環境。本番に影響を与えずに実験できる」',
   ARRAY['ide', 'code-editor', 'sandbox'],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[]),

  (12, 3, 'ターミナルとシェル',
   E'「さて、黒い画面の話じゃ」\n\n「Terminal（ターミナル）は、コマンドを入力する画面のこと」\n\n「Command line（コマンドライン）や CLI（シーエルアイ）とも呼ばれる」\n\n「Shell（シェル）は、コマンドを解釈して実行するプログラムのことじゃ」\n\n「Bash（バッシュ）は、最も一般的なシェルの一つ」\n\n「マウスでポチポチするより、コマンドの方が速いことも多いぞ」',
   ARRAY['terminal', 'command-line', 'cli', 'shell', 'bash'],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[]),

  (12, 4, '新しいターミナル',
   E'「最近は便利なターミナルもある」\n\n「Warp（ワープ）は、モダンで使いやすいターミナルアプリじゃ」\n\n「AI がコマンドを提案してくれたり、出力をブロックごとに整理してくれる」\n\n「Warp (as coding agent) としても使える——つまり、Coding agent（コーディングエージェント）として、コードの修正や生成を手伝ってくれるんじゃ」\n\n「AI と一緒にコーディングする時代が来ているんじゃなあ」',
   ARRAY['warp', 'warp-as-coding-agent', 'coding-agent'],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[]),

  (12, 5, 'ブラウザの開発ツール',
   E'「ブラウザにも強力な道具がある」\n\n「Dev tools（開発者ツール）は、ブラウザに内蔵された開発支援機能じゃ」\n\n「F12 キー、または右クリックから Inspect（検証）で開けるぞ」\n\n「Console panel（コンソールパネル）では、JavaScript のログやエラーが見られる」\n\n「Network panel（ネットワークパネル）では、通信の内容を確認できる」\n\n「Network log（ネットワークログ）で、どんなリクエストが飛んでいるか一目瞭然じゃ」',
   ARRAY['dev-tools', 'inspect', 'console-panel', 'network-panel', 'network-log'],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[]),

  (12, 6, 'デバッグの技術',
   E'「Debugger（デバッガー）は、プログラムの実行を止めて中身を確認する道具じゃ」\n\n「Call stack（コールスタック）は、関数がどの順番で呼ばれたかの記録」\n\n「Stack trace（スタックトレース）は、エラーが起きたときの呼び出し履歴を表示したもの」\n\n「下から上に読むと、何がきっかけでエラーになったかわかるぞ」',
   ARRAY['debugger', 'call-stack', 'stack-trace'],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[]),

  (12, 7, '更新とエラー',
   E'「ページがおかしいときは、まず Refresh（リフレッシュ・更新）じゃ」\n\n「それでもダメなら Hard refresh（ハードリフレッシュ）——キャッシュを無視して完全に再読み込み」\n\n「Screenshot（スクリーンショット）を撮って、エラーの状態を記録するのも大切じゃ」\n\n「Error（エラー）は、プログラムの問題を示すメッセージ」\n\n「Crash（クラッシュ）は、プログラムが完全に止まること」\n\n「Network error（ネットワークエラー）は、通信に問題があるときのエラーじゃ」',
   ARRAY['refresh', 'hard-refresh', 'screenshot', 'error', 'crash', 'network-error'],
   ARRAY['dddddddd-dddd-dddd-dddd-dddddddddddd']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 13: パッケージ配送センター
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (13, 1, '配送センター',
   E'洞窟を抜けると、巨大な配送センターがあった。たくさんのトラックが行き来している。\n\n「やあ！僕はパッケージ配達員。世界中の開発者に便利なパッケージを届けているんだ」\n\n「Package（パッケージ）は、誰かが作った便利なコードの塊。自分で一から作らなくても、パッケージを使えば時間短縮になるよ」',
   ARRAY['package'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[]),

  (13, 2, 'npm の世界',
   E'「npm（エヌピーエム）は、Node Package Manager の略。JavaScript のパッケージ管理ツールだよ」\n\n「npm package（npmパッケージ）は、npm で配布されているパッケージのこと」\n\n「npm install（インストール）は、パッケージをダウンロードするコマンド」\n\n「npm run は、スクリプトを実行するコマンド」\n\n「npx は、パッケージをインストールせずに一時的に実行するコマンドだよ」',
   ARRAY['npm', 'npm-package', 'npm-install', 'npm-run', 'npx'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[]),

  (13, 3, 'Yarn と選択肢',
   E'「Yarn（ヤーン）も人気のあるパッケージマネージャーだよ」\n\n「npm と同じことができるけど、少しコマンドが違う」\n\n「どちらを使うかはチームで決めるけど、機能的にはほぼ同じだよ」\n\n「Packages（パッケージズ）は、パッケージの複数形。プロジェクトで使うたくさんのパッケージを指すね」',
   ARRAY['yarn', 'packages'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[]),

  (13, 4, '依存関係',
   E'「Dependency（依存関係）は、プロジェクトが必要とするパッケージのこと」\n\n「React を使うプロジェクトなら、React がプロジェクトの依存関係だね」\n\n「Dev dependency（開発依存）は、開発時だけ必要なパッケージ」\n\n「テストツールや、コード整形ツールなどがこれに当たる」',
   ARRAY['dependency', 'dev-dependency'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[]),

  (13, 5, '設定ファイル',
   E'「Package.json（パッケージジェイソン）は、プロジェクトの設定ファイルだよ」\n\n「どんなパッケージを使っているか、どんなスクリプトがあるか、全部ここに書いてあるんだ」\n\n「Package-lock.json は Lock file（ロックファイル）の一種。正確なバージョンを固定するよ」\n\n「Node modules（ノードモジュールズ）は、インストールしたパッケージが入っているフォルダだよ」',
   ARRAY['package-json', 'package-lock-json', 'lock-file', 'node-modules'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[]),

  (13, 6, 'バージョン管理',
   E'「Semantic versioning（セマンティックバージョニング）は、バージョン番号の付け方のルールだよ」\n\n「1.2.3——メジャー.マイナー.パッチ」\n\n「メジャーは大きな変更（互換性なし）、マイナーは機能追加（互換性あり）、パッチはバグ修正」\n\n「バージョンを固定しないと、『昨日は動いたのに今日は動かない！』なんてことが起きるんだ」',
   ARRAY['semantic-versioning'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[]),

  (13, 7, '環境の種類',
   E'「開発には複数の『環境』があるよ」\n\n「Development environment（開発環境）は、開発者がコードを書いて試す環境」\n\n「Staging environment（ステージング環境）は、本番に近い状態でテストする環境」\n\n「Preview environment（プレビュー環境）は、変更をレビューするための一時的な環境」\n\n「Production environment（本番環境）は、実際にユーザーが使う環境」\n\n「Environment variable（環境変数）は、環境ごとに異なる設定値を外部から渡す仕組みだよ」',
   ARRAY['development-environment', 'staging-environment', 'preview-environment', 'production-environment', 'environment-variable'],
   ARRAY['eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 14: 時の図書館
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (14, 1, '時の図書館',
   E'配送センターを出ると、古めかしい図書館が現れた。でも中に入ると、無数の光る線が時間軸のように浮かんでいた。\n\n「ようこそ、時の図書館へ。私はギット管理人」\n\n「ここでは、コードの『歴史』を記録し、管理する方法を教えよう」\n\n「Git（ギット）は、バージョン管理システム——コードの変更履歴を記録・管理するツールだ」',
   ARRAY['git'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 2, 'リポジトリ',
   E'「Repository（リポジトリ）は、プロジェクトの保管庫だ。コードと、その全履歴が入っている」\n\n「GitHub（ギットハブ）は、リポジトリをオンラインで共有・管理するサービスだ」\n\n「Clone（クローン）は、リポジトリを自分のパソコンにコピーすること」\n\n「Fork（フォーク）は、他人のリポジトリを自分のアカウントにコピーすること」\n\n「クローンは『借りる』、フォークは『自分のものにする』というイメージだ」',
   ARRAY['repository', 'github', 'clone', 'fork'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 3, 'ブランチ',
   E'「Branch（ブランチ）は、開発の『枝分かれ』だ」\n\n光る線が枝分かれしている様子が見えた。\n\n「Main branch（メインブランチ）は、本流——本番環境のコードだ」\n\n「Feature branch（フィーチャーブランチ）は、新機能を開発するための枝」\n\n「枝分かれして開発し、完成したら本流に戻す」\n\n「Checkout（チェックアウト）は、ブランチを切り替えること」',
   ARRAY['branch', 'main-branch', 'feature-branch', 'checkout'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 4, 'コミット',
   E'「Commit（コミット）は、変更を記録する行為だ」\n\n「セーブポイントを作るようなもの」\n\n「Staging area（ステージングエリア）は、コミットする前の『準備エリア』」\n\n「git add で変更をステージに上げ、git commit で確定する」\n\n「コミットメッセージは何を変更したか簡潔に書くこと」',
   ARRAY['commit', 'staging-area'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 5, 'プッシュとプル',
   E'「Commit/push/pull は、Git の基本的な流れだ」\n\n「Push（プッシュ）は、ローカルの変更をリモート（GitHub）に送ること」\n\n「Pull（プル）は、リモートの変更をローカルに取り込むこと」\n\n「チームで開発するときは、まず Pull して最新を取得、作業して Commit、最後に Push する」',
   ARRAY['commit-push-pull', 'push', 'pull'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 6, 'マージ',
   E'「Merge（マージ）は、ブランチを統合すること」\n\n「Merge conflict（マージコンフリクト）は、同じ場所を別々に編集したとき起きる衝突」\n\n「どちらを採用するか、手動で解決する必要がある」\n\n「Rebase（リベース）は、ブランチの起点を移動させる別のマージ方法だ」',
   ARRAY['merge', 'merge-conflict', 'rebase'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 7, '便利なコマンド',
   E'「他にも便利なコマンドがある」\n\n「Stash（スタッシュ）は、作業中の変更を一時的に退避」\n\n「Reset（リセット）は、コミットを取り消す」\n\n「Revert（リバート）は、コミットを打ち消す新しいコミットを作る」\n\n「Diff（ディフ）は、変更点を確認するコマンド」\n\n「.gitignore（ギットイグノア）は、Git で追跡しないファイルを指定する」',
   ARRAY['stash', 'reset', 'revert', 'diff', 'gitignore'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[]),

  (14, 8, 'プルリクエスト',
   E'「Pull request（プルリクエスト）は、変更を本流に取り込んでもらう『お願い』だ」\n\n「GitHub 上で作成する」\n\n「Code review（コードレビュー）は、他の人がコードをチェックすること」\n\n「レビューで承認されたら、マージされる」\n\n「GitHub Actions（ギットハブアクションズ）は、プッシュやプルリクエストをきっかけに自動でテストやデプロイを実行する仕組みだ」',
   ARRAY['pull-request', 'code-review', 'github-actions'],
   ARRAY['ffffffff-ffff-ffff-ffff-ffffffffffff']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 15: サーバーの城
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (15, 1, '城への到着',
   E'時の図書館を出ると、堂々たる城がそびえていた。\n\n「サーバーの城へようこそ！」\n\n鎧を着た騎士が出迎えた。\n\n「私はサーバー守護者。この城——Backend（バックエンド）を守っている」\n\n「Backend、または Back end は、ユーザーから見えない裏側の処理を担当する」\n\n「Server（サーバー）は、リクエストを受け取って処理を行うコンピュータだ」\n\n「Server side（サーバーサイド）は、サーバーで実行される処理のこと」',
   ARRAY['backend', 'back-end', 'server', 'server-side'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 2, '表と裏',
   E'「対になる概念を説明しよう」\n\n「Frontend / Front end（フロントエンド）は、ユーザーが直接触れる画面側」\n\n「Client side（クライアントサイド）は、ユーザーのブラウザで実行される処理」\n\n「Full stack（フルスタック）は、両方できる開発者のことだ」',
   ARRAY['frontend', 'front-end', 'client-side', 'full-stack'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 3, 'ルーティング',
   E'「城には様々な部屋がある。どの部屋に案内するか決めるのが Route（ルート）だ」\n\n「Routes は複数のルート。Endpoint（エンドポイント）とも呼ばれる」\n\n「Router（ルーター）は、リクエストを適切なルートに振り分ける仕組み」\n\n「Route security（ルートセキュリティ）は、認証されたユーザーだけがアクセスできるようにする保護だ」',
   ARRAY['route', 'routes', 'endpoint', 'router', 'route-security'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 4, '処理の流れ',
   E'「リクエストがどう処理されるか説明しよう」\n\n「Controller（コントローラー）は、リクエストを受け取って処理を振り分ける司令塔」\n\n「Service（サービス）は、Business logic（ビジネスロジック）——実際の処理を行う部分」\n\n「Model（モデル）は、データの形を定義し、データベースとやり取りする」\n\n「Handler（ハンドラー）は、特定の処理を担当する関数」',
   ARRAY['controller', 'service', 'business-logic', 'model', 'handler'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 5, 'ミドルウェア',
   E'「Middleware（ミドルウェア）は、リクエストとレスポンスの間に挟まる処理だ」\n\n「認証チェック、ログ記録、データの変換などを行う」\n\n「玄関で身分証を確認する警備員のようなものだ」',
   ARRAY['middleware'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 6, 'REST API',
   E'「REST（レスト）は、API の設計スタイルだ」\n\n「RESTful（レストフル）は、REST の原則に従っていること」\n\n「Stateless（ステートレス）は、サーバーがクライアントの状態を覚えていないこと」\n\n「毎回、必要な情報をリクエストに含めて送る」\n\n「Session（セッション）は、ユーザーの状態を一時的に保存する仕組み」\n\n「Cookie（クッキー）は、ブラウザに保存される小さなデータ。ログイン状態の維持などに使う」',
   ARRAY['rest', 'restful', 'stateless', 'session', 'cookie'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 7, 'リクエストの中身',
   E'「リクエストの構造を見てみよう」\n\n「Header（ヘッダー）は、リクエストの付加情報」\n\n「Body（ボディ）は、リクエストの本文——送るデータ」\n\n「Payload（ペイロード）も Body と同じ意味で使われる」',
   ARRAY['header', 'body', 'payload'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[]),

  (15, 8, 'HTTPメソッド',
   E'「HTTP メソッドは、何をしたいかを示す」\n\n「GET は『取得したい』」\n「POST は『新しく作りたい』」\n「PUT は『更新したい』」\n\n「これらを正しく使い分けることが、RESTful な API 設計の基本だ」\n\n「次の章では、API についてもっと詳しく学ぼう」',
   ARRAY['http-get', 'http-post', 'http-put'],
   ARRAY['00000000-0000-0000-0001-000000000001']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 16: APIの大使館
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (16, 1, '大使館への招待',
   E'サーバーの城を出ると、世界各国の旗がはためく壮麗な建物があった。\n\n「ここは API の大使館。私は API 大使です」\n\n「API（エーピーアイ）は、Application Programming Interface——ソフトウェア同士が会話するための『窓口』なんです」\n\n「大使館が国と国をつなぐように、API はアプリとアプリをつなぎます」',
   ARRAY['api'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 2, 'API の基本',
   E'「API call（APIコール）は、API に対するリクエストのこと」\n\n「API endpoint（APIエンドポイント）は、API の具体的な URL」\n\n「API key（APIキー）は、API を使う権限を持っていることを証明する鍵です」\n\n「この鍵がないと、API を使わせてもらえません」\n\n「API キーは秘密！絶対に公開しないでくださいね」',
   ARRAY['api-call', 'api-endpoint', 'api-key'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 3, 'CRUD と HTTP メソッド',
   E'「CRUD（クラッド）は、データ操作の4つの基本です」\n\n「C - Create（作成）→ POST\nR - Read（読取）→ GET\nU - Update（更新）→ PUT\nD - Delete（削除）→ DELETE」\n\n「HTTP methods（HTTPメソッド）でこれらを表現します」\n\n「DELETE は、データを削除するメソッド」\n\n「REST API は、これらのメソッドを使った API の設計スタイルです」',
   ARRAY['crud', 'http-methods', 'delete', 'rest-api'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 4, 'GraphQL',
   E'「GraphQL（グラフキューエル）は、REST とは違う API の形式です」\n\n「Query（クエリ）で、欲しいデータだけを指定して取得」\n\n「Mutation（ミューテーション）で、データを変更します」\n\n「REST は URL ごとにデータが決まっていますが、GraphQL はクライアントが欲しいデータを選べるんです」',
   ARRAY['graphql', 'query', 'mutation'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 5, 'リアルタイム通信',
   E'「WebSocket（ウェブソケット）は、サーバーとクライアントが常につながっている通信方式です」\n\n「Socket（ソケット）は、その接続口のこと」\n\n「Real-time（リアルタイム）なデータのやり取りが可能になります」\n\n「チャットアプリや株価表示など、即座に更新が必要な場面で使います」\n\n「Real-time Subscription は、データの変更を自動で受け取る仕組み。GraphQL でよく使われます」',
   ARRAY['websocket', 'socket', 'real-time', 'real-time-subscription'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 6, 'Webhook と Callback',
   E'「Webhook（ウェブフック）は、イベントが起きたら自動で通知する仕組み」\n\n「たとえば、『決済が完了したら、このURLに教えて』と登録しておく」\n\n「Callback（コールバック）は、処理が終わったら呼び出される関数」\n\n「Callback ID は、どのコールバックかを識別する ID」\n\n「Invocation（インボケーション）は、関数やAPIを呼び出すこと」',
   ARRAY['webhook', 'callback', 'callback-id', 'invocation'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 7, '制限と制御',
   E'「API には様々な制限があります」\n\n「Rate limit（レートリミット）は、一定時間内のリクエスト数制限」\n\n「Throttling（スロットリング）は、リクエストを制限・遅延させること」\n\n「Debouncing（デバウンシング）は、連続したイベントの最後だけを処理」\n\n「Timeout（タイムアウト）は、一定時間応答がないときに処理を打ち切ること」',
   ARRAY['rate-limit', 'throttling', 'debouncing', 'timeout'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 8, 'CORS と SDK',
   E'「CORS（コース）は、Cross-Origin Resource Sharing——異なるドメイン間でのデータ共有を制御する仕組みです」\n\n「セキュリティのため、デフォルトでは別ドメインからのアクセスはブロックされます」\n\n「サーバー側で許可設定が必要です」\n\n「SDK（エスディーケー）は、Software Development Kit——API を簡単に使うための道具セットです」\n\n「SDK があると、API の使い方を覚えやすくなります」',
   ARRAY['cors', 'sdk'],
   ARRAY['00000000-0000-0000-0002-000000000002']::uuid[]),

  (16, 9, '旅の終わり',
   E'API 大使が微笑んだ。\n\n「これで、500の用語を巡る旅はおしまいです」\n\nビットくんが飛び跳ねた。\n\n「やったね！全部学んだよ！」\n\n「あなたは今、プログラミングの世界の言葉を理解できるようになりました」\n\n「でも、これは終わりではなく、始まりです」\n\n「この知識を使って、実際にコードを書き、アプリを作ってみてください」\n\n「きっと、この旅で学んだ言葉たちがあなたを助けてくれるはずです」',
   ARRAY[]::text[],
   ARRAY['00000000-0000-0000-0002-000000000002', '11111111-1111-1111-1111-111111111111']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 17: エピローグ〜メモリーガーデン〜
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (17, 1, 'メモリーガーデンへの到着',
   E'第16章——APIの大使館を出たあなたは、気がつくと、見たことのない場所に立っていた。\n\n一面の花畑。しかし、花びらは光でできていて、ひとつひとつが淡く明滅している。\n\nそして——空一面を、無数の蝶が舞っていた。\n\n「ここは……」\n\n「メモリーガーデンだよ」\n\n聞き覚えのある声。振り向くと、ビットくんとバイトさんがいた。\n\n「君は、500の言葉を学んだ」\n「だから、ここに来ることができたの」\n\n「この蝶たちは……」\n「君が学ぶたびに生まれた、コードバタフライたちだよ」\n\n500匹の蝶が、祝福するように周りを舞った。',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 2, '蝶たちからの贈り物',
   E'すると、一匹の蝶があなたの手に止まった。\n\n「旅はここで終わりだけど……」\n「最後に、蝶たちから贈り物があるの」\n\n「贈り物？」\n\n「これから君が実際にコードを書くとき、きっと出会う大切な言葉たち」\n\n「本編では伝えきれなかった、でも、知っておいてほしい20の言葉」\n\n蝶たちが、ひとつずつ舞い降りてきた。',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 3, 'エラーと向き合う勇気',
   E'最初の蝶が、そっと光を放った。\n\n「プログラムは、時に失敗する」\n\n「でも、Try/catch（トライキャッチ）があれば大丈夫」\n\n「try で挑戦して、catch で失敗を受け止める」\n\n「失敗を恐れないで。ちゃんと受け止める準備があれば、挑戦できるから」\n\n次の蝶が舞い降りる。\n\n「『ない』にも種類があるんだよ」\n\n「null（ヌル）は、『意図的に空っぽ』」\n\n「undefined（アンディファインド）は、『まだ何も入っていない』」\n\n「似ているけど、意味が違う。この違いを知っておくと、バグの原因が見つけやすくなるよ」',
   ARRAY['try-catch', 'null-undefined'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 4, 'モダンな書き方',
   E'3匹目の蝶が、優しく光る。\n\n「深いオブジェクトにアクセスするとき、途中がnullだとエラーになる」\n\n「でも、?.（Optional chaining・オプショナルチェイニング）を使えば安全だよ」\n\n「『いますか？』と確認しながら進む、慎重なノックのようなものだね」\n\n4匹目の蝶が続く。\n\n「Nullish coalescing（ヌリッシュコアレッシング）は、値がnullやundefinedのとき、代わりの値を使う ?? 演算子」\n\n5匹目。\n\n「Template literal（テンプレートリテラル）は、バッククォートで文字列に変数を埋め込む書き方」\n\n6匹目。\n\n「Ternary operator（三項演算子）は、条件 ? 真のとき : 偽のとき——if-elseの短縮形だね」',
   ARRAY['optional-chaining', 'nullish-coalescing', 'template-literal', 'ternary-operator'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 5, 'ブラウザの世界',
   E'7匹目の蝶が、温かく光る。\n\n「ブラウザにデータを保存したい？ localStorage が使えるよ」\n\n「localStorage（ローカルストレージ）は、ブラウザにデータを保存する仕組み」\n\n「ブラウザを閉じても消えないんだ。テーマ設定やお気に入りの保存に便利」\n\n「ただし、文字列しか保存できないから、オブジェクトはJSONにしてね」',
   ARRAY['localstorage'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 6, 'レイアウトの魔法',
   E'8匹目、9匹目、10匹目、11匹目——4匹の蝶が連なって舞い降りた。\n\n「CSSのレイアウト、教えるね」\n\n「Flexbox（フレックスボックス）は、要素を横に並べたいときに使うレイアウト」\n\n「Grid（グリッド）は、2次元のレイアウトに強力。エクセルのセルみたいに、縦横に要素を配置できる」\n\n「z-index（ゼットインデックス）は、要素が重なったとき、どっちが前に来るかを決める。数字が大きいほど手前に来るよ」\n\n「Box model（ボックスモデル）——全ての要素は、content（中身）、padding（内側の余白）、border（枠線）、margin（外側の余白）の4つの層でできている」',
   ARRAY['flexbox', 'grid-css', 'z-index', 'box-model'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 7, '画面サイズへの適応',
   E'12匹目と13匹目が、一緒に舞い降りた。\n\n「スマホでもPCでもきれいに見せたい——それが Responsive design（レスポンシブデザイン）」\n\n「画面サイズに応じて、レイアウトを変えるんだ」\n\n「Breakpoint（ブレークポイント）は、レイアウトが切り替わる境界のこと」\n\n「小さい画面から作り始める、『モバイルファースト』がおすすめ」',
   ARRAY['responsive-design', 'breakpoint-css'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 8, 'HTTPの言葉',
   E'14匹目の蝶が、静かに止まった。\n\n「HTTPのレスポンスには、数字で結果が返ってくる」\n\n「Status code（ステータスコード）——200はOK、404は見つからない、500はサーバーエラー」\n\n「4xx は『あなた側の問題』、5xx は『サーバー側の問題』」\n\n「この数字で、何が起きたかわかるんだ」',
   ARRAY['status-code'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 9, '世界に届ける',
   E'15匹目、16匹目、17匹目、18匹目——4匹が続けて舞い降りる。\n\n「君の作品を、世界に届けよう」\n\n「Deploy（デプロイ）は、アプリを公開すること。開発したコードをサーバーに置いて、誰でもアクセスできる状態にする」\n\n「Hosting（ホスティング）は、サイトを公開する場所を借りること。Vercel、Netlify、AWS……いろんなサービスがあるよ」\n\n「Domain（ドメイン）は、example.com みたいな、サイトの住所」\n\n「SSL / HTTPS は、通信を暗号化する鍵。https:// で始まるサイトは、通信が暗号化されてる。今の時代、HTTPSは必須だよ」',
   ARRAY['deploy', 'hosting', 'domain', 'ssl-https'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 10, '見つけてもらうために',
   E'19匹目の蝶が、あなたの肩に止まった。\n\n「SEO——Search Engine Optimization、検索エンジン最適化」\n\n「Googleで検索したとき、上の方に表示されたいでしょ？」\n\n「タイトル、説明文、ページの構造、読み込み速度……いろんな工夫で、見つけてもらいやすくなるんだ」\n\n「でも一番大切なのは、良いコンテンツを作ること」',
   ARRAY['seo'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 11, 'すべての人のために',
   E'そして——最後の蝶が、舞い降りた。500匹目の蝶。ひときわ大きく、美しく輝いていた。\n\n「Accessibility（アクセシビリティ）は、すべての人が使えるようにする配慮」\n\n「目が見えにくい人、耳が聞こえにくい人、マウスが使えない人……誰もが、君の作品を楽しめるようにする」\n\n「これは最後に対応するんじゃなくて、最初から意識して作るもの」\n\n蝶は、優しく言った。\n\n「すべての人のために作る。それが、本当に美しいコードだよ」',
   ARRAY['accessibility'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 12, '旅の終わり、新しい始まり',
   E'20匹の蝶が、あなたの周りを舞った。そして、500匹すべての蝶が空高く舞い上がった。\n\n光の渦が、庭全体を包み込む。\n\n「君は、520の言葉を学んだ」\n\nビットくんが、眩しそうに笑った。\n\n「でも、これは終わりじゃないよ」\n\nバイトさんが続ける。\n\n「言葉を知っているだけじゃ、まだ話せない」\n\n「実際にコードを書いて、失敗して、また書いて……」\n\n「そうして初めて、言葉が『力』になるの」\n\n「でも、もう怖くないでしょ？」\n「だって君は、言葉を知っているから」\n「どこから始めればいいか、わかるから」\n\n「私たちは、いつでも君と一緒にいるよ」\n\n「さようなら、旅人さん」\n「そして——」\n「おかえりなさい、エンジニアさん」',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (17, 13, '新しい世界へ',
   E'光が収まると——気がつくと、自分のパソコンの前に座っていた。\n\n画面には、空っぽのエディタ。そして、点滅するカーソル。\n\nふと窓の外を見ると——一瞬だけ、光の蝶が舞ったような気がした。\n\nいや、確かに見えた。\n\nあなたは微笑んで、キーボードに手を置いた。\n\nエディタに、最初の一文字を打つ。\n\nconst greeting = \"Hello, World!\";\nconsole.log(greeting);\n\n実行ボタンを押す。\n\n    Hello, World!\n\n画面に文字が表示された瞬間——心の中で、小さな蝶が羽ばたいた気がした。\n\n「さあ、何を作ろうかな」\n\n520の言葉と、520匹の蝶を連れて、あなたの本当の旅が始まる。',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[])
ON CONFLICT DO NOTHING;
