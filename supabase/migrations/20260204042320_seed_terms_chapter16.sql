/*
  # Seed Chapter 16 Terms - API（最終章）

  1. Content
    - Seeds 45 programming terms for Chapter 16 (API - The Embassy)
    - Topics include: HTTP methods, REST API, GraphQL, WebSocket, Authentication,
      JSON, Caching, CDN, Rate limiting, API documentation
    - This is the final chapter of the 500-term journey

  2. Terms Added (45 total)
    - DELETE, CRUD, HTTP methods, API basics
    - API key, API call, API endpoint, REST API
    - GraphQL, Query, Mutation, WebSocket
    - Socket, Real-time, Subscription, Webhook
    - Callback, Rate limit, Throttling, Debouncing
    - CORS, SDK, Authentication, Authorization
    - Token, JWT, OAuth, JSON, XML
    - Serialization, Cache, CDN, Latency
    - Load balancing, Pagination, API Versioning
    - Deprecation, Idempotent, Retry, Fallback
    - API Documentation
*/

INSERT INTO terms (id, term, term_ja, chapter_id, order_index, difficulty, one_liner, definition, mechanism, analogy, pitfall, related_terms, story_context)
VALUES
  ('delete', 'DELETE', 'デリート', 16, 1, 1, 'データを削除するHTTPメソッド', '指定したリソースを削除するHTTPメソッド。DELETE /users/123 でID123のユーザーを削除。', '冪等な操作。同じリクエストを何度送っても結果は同じ（すでに削除済みならそのまま）。', '図書館から本を除籍。不要になった本を棚から取り除く。', '削除は取り消せない。論理削除（deleted_atフラグ）を使うことも検討する。', ARRAY['get-method', 'post', 'crud'], '大使館の門をくぐると、API大使が「最終章へようこそ」と迎えてくれた。'),

  ('crud', 'CRUD', 'クラッド', 16, 2, 1, 'データ操作の4つの基本操作', 'Create（作成）、Read（読取）、Update（更新）、Delete（削除）の頭文字。データ操作の基本パターン。', 'POST（Create）、GET（Read）、PUT/PATCH（Update）、DELETE（Delete）に対応。', 'ノートの使い方。書く（Create）、読む（Read）、書き直す（Update）、消す（Delete）。', '全てのAPIがCRUDで表現できるわけではない。アクション系は別の設計が必要なことも。', ARRAY['post', 'get-method', 'put'], '「CRUD は、データ操作の基本4操作です」'),

  ('http-methods', 'HTTP methods', 'HTTPメソッド', 16, 3, 1, 'HTTPリクエストの操作種別', 'HTTPリクエストで実行したい操作の種類を示す。GET、POST、PUT、PATCH、DELETE、HEAD、OPTIONSなどがある。', 'URLと組み合わせてリソースへの操作を表現。GET /users は「ユーザー一覧を取得」という意味に。', '動詞。「本を」の後に「読む」「書く」「消す」など、何をするかを示す言葉。', '正しいメソッドを使う。データ取得にPOSTを使うなど、不適切な使い方を避ける。', ARRAY['get-method', 'post', 'put'], '「HTTP methods は、リクエストの『動詞』です」'),

  ('api', 'API', 'エーピーアイ', 16, 4, 1, 'システム間の通信インターフェース', 'Application Programming Interfaceの略。異なるソフトウェア同士がやり取りするための決まりごと・窓口。', 'リクエストを送ると、決まった形式でレスポンスが返る。REST API、GraphQL APIなどの形式がある。', '大使館の窓口。外国（他のシステム）とやり取りするための公式な窓口。', 'APIの仕様が変わるとクライアントに影響。バージョニングで互換性を管理する。', ARRAY['rest-api', 'api-endpoint', 'api-call'], '「API は、異なるシステムをつなぐ外交の窓口です」'),

  ('api-key', 'API key', 'APIキー', 16, 5, 1, 'API利用のための認証キー', 'APIを利用する際に必要な認証用の文字列。誰がAPIを使っているかを識別し、利用制限や課金に使用。', 'リクエストヘッダーやクエリパラメータに含めて送信。サーバーで検証して認証。', '入館証。この証（キー）がないと建物（API）に入れない。', 'APIキーは絶対に公開しない。GitHubに上げない、フロントエンドに埋め込まない。', ARRAY['api', 'authentication', 'environment-variable'], '「API key は、大使館に入るための許可証です」'),

  ('api-call', 'API call', 'API呼び出し', 16, 6, 1, 'APIにリクエストを送ること', 'APIエンドポイントにHTTPリクエストを送信し、レスポンスを受け取る一連の操作。', 'fetch()やaxiosでリクエストを送信。非同期で実行され、Promiseでレスポンスを受け取る。', '電話をかける。相手（API）に電話（リクエスト）をかけて、返事（レスポンス）をもらう。', 'API呼び出しは失敗することがある。エラーハンドリングを必ず実装する。', ARRAY['api', 'fetch', 'request'], '「API call は、外国に連絡を取る行為です」'),

  ('api-endpoint', 'API endpoint', 'APIエンドポイント', 16, 7, 1, 'APIの特定の機能にアクセスするURL', 'APIが提供する特定の機能やリソースにアクセスするためのURL。https://api.example.com/users など。', 'ベースURL + パスでエンドポイントを構成。HTTPメソッドと組み合わせて機能を特定。', '大使館の各部署の窓口。「ビザ申請はこちら」「問い合わせはこちら」と窓口が分かれている。', 'エンドポイントの設計は一貫性を持たせる。命名規則を統一する。', ARRAY['api', 'endpoint', 'url'], '「API endpoint は、大使館内の各窓口です」'),

  ('rest-api', 'REST API', 'レストエーピーアイ', 16, 8, 1, 'RESTの原則に従ったAPI', 'RESTアーキテクチャスタイルに従って設計されたAPI。HTTPメソッドとURLでリソースを操作する最も一般的な形式。', 'リソースをURLで表現し、HTTPメソッドで操作。JSONでデータをやり取りすることが多い。', '国際標準の外交プロトコル。世界共通のルールに従って外交を行う。', '完全にRESTfulである必要はない。実用性を優先して設計する。', ARRAY['rest', 'api', 'graphql'], '「REST API は、最も一般的な外交プロトコルです」'),

  ('graphql', 'GraphQL', 'グラフキューエル', 16, 9, 2, '必要なデータだけを取得できるクエリ言語', 'Facebookが開発したAPIのためのクエリ言語。クライアントが必要なデータの形を指定して取得できる。', '単一のエンドポイントにクエリを送信。欲しいフィールドを指定し、過不足ないデータを取得。', 'オーダーメイドの注文。「この部分とこの部分だけください」と細かく指定できる。', '学習コストがある。シンプルなAPIならREST APIで十分なことも多い。', ARRAY['rest-api', 'query', 'mutation'], '「GraphQL は、必要なものだけを注文できる新しい外交方式です」'),

  ('query', 'Query', 'クエリ', 16, 10, 1, 'データを取得するための問い合わせ', 'データベースやAPIに対してデータを取得するための問い合わせ。GraphQLではデータ取得の操作を指す。', 'GraphQLでは query { user { name } } のような形式。SQLでは SELECT 文に相当。', '質問。「これを教えてください」とデータを問い合わせる。', '複雑なクエリはパフォーマンスに影響。N+1問題などに注意。', ARRAY['graphql', 'mutation', 'database'], '「Query は、情報を問い合わせる外交文書です」'),

  ('mutation', 'Mutation', 'ミューテーション', 16, 11, 2, 'GraphQLでデータを変更する操作', 'GraphQLでデータの作成・更新・削除を行う操作。RESTのPOST、PUT、DELETEに相当。', 'mutation { createUser(name: "太郎") { id } } のような形式で実行。', '申請書。「これを変更してください」「これを登録してください」という依頼。', '副作用を伴う操作は全てMutationで。Queryはデータを変更しない。', ARRAY['graphql', 'query', 'crud'], '「Mutation は、変更を依頼する外交文書です」'),

  ('websocket', 'WebSocket', 'ウェブソケット', 16, 12, 2, '双方向リアルタイム通信のプロトコル', 'クライアントとサーバーの間で双方向のリアルタイム通信を行うためのプロトコル。チャットやゲームに使用。', '一度接続を確立すると、サーバーからもクライアントにプッシュできる。常時接続を維持。', '電話回線。一度つながると、お互いにいつでも話しかけられる。HTTPは手紙のやり取り。', '接続を維持するためリソースを消費。必要な場面でのみ使用する。', ARRAY['socket', 'real-time', 'http'], '「WebSocket は、常時つながったホットラインです」'),

  ('socket', 'Socket', 'ソケット', 16, 13, 2, 'ネットワーク通信の接続口', 'ネットワーク通信を行うための抽象的な接続ポイント。データの送受信を行う「差込口」のようなもの。', 'IPアドレスとポート番号で特定。TCP/UDPでデータを送受信。', 'コンセント。電気（データ）を流すための差込口。プラグを挿すと通信が始まる。', 'Socket.ioなどのライブラリを使うと実装が楽。生のソケットは扱いが難しい。', ARRAY['websocket', 'port', 'connection'], '「Socket は、通信のための接続口です」'),

  ('real-time', 'Real-time', 'リアルタイム', 16, 14, 1, '即座に反映される通信・処理', '遅延なく即座にデータが反映される通信や処理。チャット、株価表示、オンラインゲームなどで必要。', 'WebSocket、Server-Sent Events、ポーリングなどで実現。用途に応じて選択。', '生放送。録画（バッチ処理）ではなく、今起きていることがすぐに届く。', 'リアルタイムは負荷が高い。本当にリアルタイムが必要か検討する。', ARRAY['websocket', 'real-time-subscription', 'polling'], '「Real-time は、即座に届く緊急通信です」'),

  ('real-time-subscription', 'Real-time Subscription', 'リアルタイムサブスクリプション', 16, 15, 2, '変更を自動で受け取る仕組み', 'GraphQLでサーバー側の変更をリアルタイムに受け取る仕組み。データが更新されると自動的にクライアントに通知。', 'WebSocketベースで実装。subscription { messageAdded { content } } のように定義。', '新聞の定期購読。新しい記事（データ）が出たら、自動的に届けてもらえる。', '購読しっぱなしだとリソースを消費。不要になったら解除する。', ARRAY['graphql', 'websocket', 'real-time'], '「Subscription は、変更があれば即座に届く定期便です」'),

  ('webhook', 'Webhook', 'ウェブフック', 16, 16, 2, 'イベント発生時に通知を送る仕組み', '特定のイベントが発生したときに、指定したURLに自動でHTTPリクエストを送る仕組み。逆API、HTTPコールバックとも。', '決済完了、コミット、フォーム送信などのイベント発生時に、登録したURLにPOSTリクエスト。', 'イベント時の電話連絡。「支払いが完了したら電話してね」と頼んでおく。', 'Webhookの受信側は認証を実装。偽のリクエストを防ぐ。', ARRAY['callback', 'event', 'api'], '「Webhook は、イベント発生時の自動連絡システムです」'),

  ('callback', 'Callback', 'コールバック', 16, 17, 1, '処理完了後に呼び出される関数', 'ある処理が完了した後に実行される関数。非同期処理の結果を受け取るために使われる。', '関数を引数として渡し、処理完了時に呼び出してもらう。fetchData(data => console.log(data))のように。', '「終わったら電話して」。頼んだ仕事が終わったら、報告の電話（コールバック）をもらう。', 'コールバック地獄に注意。ネストが深くなったらPromiseやasync/awaitを使う。', ARRAY['promise', 'async', 'event-handler'], '「Callback は、処理完了の報告を受ける仕組みです」'),

  ('callback-id', 'Callback ID', 'コールバックID', 16, 18, 2, 'コールバックを識別するためのID', '複数のコールバック処理を区別するための一意の識別子。どのリクエストへの応答かを特定するのに使用。', 'リクエスト時にIDを付与し、レスポンス時に同じIDを返す。非同期処理の追跡に使用。', '整理番号。「123番でお待ちの方」と呼ばれたら、自分の番号かどうかわかる。', 'IDは一意であることを保証する。UUID等を使用すると安全。', ARRAY['callback', 'async', 'request'], '「Callback ID は、依頼の整理番号です」'),

  ('invocation', 'Invocation', 'インボケーション', 16, 19, 2, '関数やAPIの呼び出し', '関数やAPIを実行すること。Lambda関数の実行回数などをカウントする際にも使われる用語。', '関数を呼び出す行為そのもの。myFunction() の () がinvocation（呼び出し）を行う。', '召喚。魔法（関数）を唱えて、効果を発動させる行為。', 'サーバーレスでは呼び出し回数で課金されることが多い。無駄な呼び出しを避ける。', ARRAY['function', 'api-call', 'lambda'], '「Invocation は、機能を呼び出す行為です」'),

  ('rate-limit', 'Rate limit', 'レートリミット', 16, 20, 2, 'APIの呼び出し回数制限', '一定時間内にAPIを呼び出せる回数の上限。サーバーの過負荷防止や、プランごとの利用制限に使用。', '1分間に60回まで、1日1000回までなど。超過するとHTTP 429（Too Many Requests）エラー。', '入場制限。「1時間に100人まで」と決めて、混雑を防ぐ。', 'レートリミットに達したら、リトライ間隔を空ける。指数バックオフが一般的。', ARRAY['throttling', 'api', '429'], '「Rate limit は、面会回数の制限です」'),

  ('throttling', 'Throttling', 'スロットリング', 16, 21, 2, '処理速度を意図的に制限すること', 'リクエストの処理速度を意図的に制限すること。サーバー保護やAPI利用量の制御に使用。', '一定間隔でしか処理を実行しない。超過したリクエストは待機させるか拒否する。', '水道の蛇口を絞る。水（リクエスト）の流れを制限して、溢れないようにする。', 'throttleとdebounceを混同しない。throttleは一定間隔で実行、debounceは最後のみ実行。', ARRAY['rate-limit', 'debouncing', 'performance'], '「Throttling は、対応速度を調整することです」'),

  ('debouncing', 'Debouncing', 'デバウンシング', 16, 22, 2, '連続した呼び出しをまとめる', '短時間に連続して発生するイベントをまとめ、最後の1回だけ処理する手法。検索入力の最適化などに使用。', 'イベント発生後、一定時間待って実行。その間に新しいイベントがあればタイマーをリセット。', 'エレベーターのドア。人が乗り込むたびに閉まるのを待つ。落ち着いたら閉まる。', '待ち時間が長すぎるとレスポンスが悪くなる。適切な時間（300ms程度）を設定。', ARRAY['throttling', 'performance', 'event'], '「Debouncing は、落ち着くまで待ってから対応することです」'),

  ('timeout', 'Timeout', 'タイムアウト', 16, 23, 1, '制限時間を超えて処理を中断', '一定時間内に応答がない場合に、処理を中断すること。無限に待ち続けることを防ぐ。', 'リクエスト時にタイムアウト時間を設定。時間内に応答がなければエラーとして処理。', '待ち合わせの制限時間。30分待って来なければ、待つのをやめる。', 'タイムアウトが短すぎると正常なリクエストも失敗する。適切な時間を設定。', ARRAY['error', 'network-error', 'retry'], '「Timeout は、待ち時間の限界です」'),

  ('cors', 'CORS', 'コース', 16, 24, 2, '異なるオリジン間の通信を許可する仕組み', 'Cross-Origin Resource Sharingの略。ブラウザがセキュリティ上禁止している異なるオリジン（ドメイン）間の通信を許可する仕組み。', 'サーバーがAccess-Control-Allow-Originヘッダーで許可するオリジンを指定。', '入国許可証。「この国（オリジン）からの訪問者は受け入れOK」と宣言する。', '開発中に「CORSエラー」に悩まされがち。サーバー側の設定で解決する。', ARRAY['origin', 'security', 'header'], '「CORS は、異なる国（オリジン）からの訪問を許可する仕組みです」'),

  ('sdk', 'SDK', 'エスディーケー', 16, 25, 2, '開発を支援するツールキット', 'Software Development Kitの略。特定のサービスやプラットフォーム向けの開発ツール、ライブラリ、ドキュメントのセット。', 'APIを直接叩く代わりに、SDKの関数を呼ぶだけで機能を利用できる。認証なども簡略化。', '料理キット。材料と調味料とレシピがセットになっていて、簡単に料理（開発）できる。', 'SDKのバージョンアップに追従する。古いSDKはセキュリティリスクになることも。', ARRAY['api', 'library', 'integration'], '「SDK は、開発を助けてくれる便利な道具セットです」'),

  ('authentication', 'Authentication', '認証', 16, 26, 1, '「あなたは誰か」を確認すること', 'ユーザーが本人であることを確認するプロセス。パスワード、生体認証、トークンなどで本人確認を行う。', 'ログイン時に認証情報を検証。成功するとセッションやトークンを発行。', 'パスポートチェック。「あなたは本当に〇〇さんですか」と身分を確認する。', '認証と認可は別物。認証は「誰か」、認可は「何ができるか」。', ARRAY['authorization', 'token', 'session'], '「Authentication は、訪問者の身分確認です」'),

  ('authorization', 'Authorization', '認可', 16, 27, 2, '「何ができるか」を確認すること', '認証されたユーザーが、特定のリソースやアクションにアクセスする権限を持っているかを確認するプロセス。', 'ロール（admin、userなど）やパーミッションをチェック。権限がなければ403エラー。', '立入許可証。パスポート（認証）があっても、VIPエリアには別途許可が必要。', '認可チェックはサーバーサイドで必ず行う。フロントエンドだけでは不十分。', ARRAY['authentication', 'permission', 'role'], '「Authorization は、どこに入れるかの権限確認です」'),

  ('token', 'Token', 'トークン', 16, 28, 1, '認証情報を表す文字列', 'ユーザーの認証情報を表す暗号化された文字列。JWTが一般的。リクエストに付与してサーバーで検証。', 'ログイン成功時に発行。以降のリクエストのAuthorizationヘッダーに含めて送信。', '通行証。この証があれば、毎回パスポート（ログイン）を見せなくても通れる。', 'トークンの有効期限を適切に設定。長すぎるとセキュリティリスク、短すぎると不便。', ARRAY['authentication', 'jwt', 'bearer'], '「Token は、一度発行される通行証です」'),

  ('jwt', 'JWT', 'ジェイダブリューティー', 16, 29, 2, 'JSONベースのトークン形式', 'JSON Web Tokenの略。ヘッダー、ペイロード、署名の3部分からなる、自己完結型のトークン形式。', 'Base64エンコードされた3部分をドットで連結。署名により改ざんを検出できる。', '封印付きの手紙。内容（ペイロード）と、開封したら分かる封印（署名）がセット。', 'ペイロードは暗号化されていない。機密情報を入れない。署名で検証するだけ。', ARRAY['token', 'authentication', 'header'], '「JWT は、改ざん防止機能付きの通行証です」'),

  ('oauth', 'OAuth', 'オーオース', 16, 30, 2, '他サービスに権限を委譲する仕組み', 'ユーザーが自分の情報を別のサービスに安全に共有するための認可フレームワーク。「Googleでログイン」などで使用。', 'ユーザーが許可 → 認可コード取得 → アクセストークン取得 → APIアクセス。', '委任状。「このサービスに、私の代わりにこれをする権限を与えます」という許可。', 'OAuthは認可であり認証ではない。認証にはOpenID Connectを組み合わせる。', ARRAY['authentication', 'authorization', 'token'], '「OAuth は、権限を委任する仕組みです」'),

  ('json', 'JSON', 'ジェイソン', 16, 31, 1, 'データ交換のための軽量フォーマット', 'JavaScript Object Notationの略。人間にも機械にも読みやすいデータ交換形式。APIの標準フォーマット。', '{ "key": "value" } の形式。配列、オブジェクト、文字列、数値、真偽値、nullを表現。', '共通言語。どの国（プログラミング言語）でも理解できる共通のデータ形式。', 'JSONではキーを必ずダブルクォートで囲む。シングルクォートやクォートなしはエラー。', ARRAY['api', 'parsing', 'object'], '「JSON は、世界共通のデータ形式です」'),

  ('xml', 'XML', 'エックスエムエル', 16, 32, 2, 'タグベースのデータ形式', 'Extensible Markup Languageの略。タグで構造化されたデータ形式。SOAPなど古いAPIや設定ファイルで使用。', '<tag>内容</tag> の形式。属性も使える。HTMLに似ているが、より厳格なルール。', '公式文書。形式が厳密に決まっている、フォーマルな書式。', 'JSONより冗長で扱いが面倒。新規開発ではJSONが主流。', ARRAY['json', 'html', 'data-format'], '「XML は、伝統的な公式文書形式です」'),

  ('serialization', 'Serialization', 'シリアライゼーション', 16, 33, 2, 'データを送信可能な形式に変換', 'オブジェクトやデータ構造を、保存や送信可能な形式（JSONや文字列など）に変換すること。', 'JSON.stringify() でオブジェクトをJSON文字列に変換。逆はデシリアライゼーション。', '荷造り。複雑な形のもの（オブジェクト）を、送れる形（文字列）に梱包する。', '循環参照があるとシリアライズできない。データ構造に注意。', ARRAY['deserialization', 'json', 'parsing'], '「Serialization は、荷物を梱包することです」'),

  ('deserialization', 'Deserialization', 'デシリアライゼーション', 16, 34, 2, '文字列をデータに復元', 'シリアライズされた文字列を、元のオブジェクトやデータ構造に復元すること。', 'JSON.parse() でJSON文字列をオブジェクトに変換。APIレスポンスの処理などで使用。', '開梱。届いた荷物（文字列）を開けて、中身（オブジェクト）を取り出す。', '信頼できないデータのデシリアライズはセキュリティリスク。バリデーションを行う。', ARRAY['serialization', 'parsing', 'json'], '「Deserialization は、届いた荷物を開封することです」'),

  ('cache', 'Cache', 'キャッシュ', 16, 35, 1, 'データを一時的に保存して高速化', '頻繁にアクセスするデータを一時的に保存し、次回のアクセスを高速化する仕組み。', 'ブラウザキャッシュ、CDN、サーバーキャッシュなど複数のレイヤーで実装。', 'よく使う本を机の上に。本棚（データベース）に取りに行かなくても、すぐ手に取れる。', 'キャッシュが古いと最新データが表示されない。適切なキャッシュ戦略が必要。', ARRAY['performance', 'cdn', 'hard-refresh'], '「Cache は、よく使う情報を手元に置いておくことです」'),

  ('cdn', 'CDN', 'シーディーエヌ', 16, 36, 2, '世界中にコンテンツを配信するネットワーク', 'Content Delivery Networkの略。世界各地にサーバーを配置し、ユーザーに近い場所からコンテンツを配信。', 'オリジンサーバーのコンテンツをエッジサーバーにキャッシュ。最も近いサーバーから配信。', 'コンビニチェーン。本部（オリジン）の商品を、近くの店舗（エッジ）で受け取れる。', '動的コンテンツのキャッシュは注意。ユーザー固有の情報がキャッシュされないように。', ARRAY['cache', 'edge', 'performance'], '「CDN は、世界中に配置された出張所です」'),

  ('latency', 'Latency', 'レイテンシ', 16, 37, 2, '通信にかかる遅延時間', 'リクエストを送ってからレスポンスが届くまでの遅延時間。ミリ秒（ms）で測定。', 'ネットワーク距離、サーバー処理時間、データサイズなどが影響。CDNで軽減可能。', '電話の時差。国際電話で少し遅れて声が届くような、通信の遅れ。', 'レイテンシは0にはできない。ユーザー体験に影響しない程度に最適化を目指す。', ARRAY['performance', 'cdn', 'optimization'], '「Latency は、通信の遅延時間です」'),

  ('load-balancing', 'Load balancing', 'ロードバランシング', 16, 38, 2, '複数サーバーに負荷を分散', '複数のサーバーにリクエストを分散させ、1台に負荷が集中しないようにする仕組み。', 'ロードバランサーがリクエストを振り分け。ラウンドロビン、最小接続数などのアルゴリズム。', '銀行の受付番号。複数の窓口に順番に振り分けて、待ち時間を均等にする。', 'セッション管理に注意。同じユーザーが違うサーバーに行っても問題ないように設計。', ARRAY['scalability', 'server', 'performance'], '「Load balancing は、複数の窓口に仕事を分担させることです」'),

  ('pagination-api', 'Pagination (API)', 'ページネーション（API）', 16, 39, 1, '大量データを分割して取得', 'APIで大量のデータを一度に返さず、ページ単位で分割して返す仕組み。パフォーマンスと使いやすさを両立。', 'limit（件数）とoffset（開始位置）、またはcursor（次のページへのポインタ）で制御。', '図書館で本を10冊ずつ借りる。一度に全部は持てないので、分けて借りる。', 'オフセットベースは大量データで遅くなる。カーソルベースの方が効率的。', ARRAY['api', 'limit', 'offset'], '「Pagination は、資料を分冊で渡すことです」'),

  ('versioning', 'API Versioning', 'APIバージョニング', 16, 40, 2, 'APIのバージョンを管理する', 'APIの異なるバージョンを管理し、後方互換性を維持しながら新機能を追加する仕組み。', '/v1/users、/v2/users のようにURLにバージョンを含める方法が一般的。', '法律の改正。古い法律も有効なまま、新しい法律を追加していく。', 'バージョンが増えすぎると管理が大変。古いバージョンは計画的に廃止する。', ARRAY['api', 'backward-compatibility', 'deprecation'], '「Versioning は、外交プロトコルの版を管理することです」'),

  ('deprecation', 'Deprecation', '非推奨化', 16, 41, 2, '古い機能を「使わないで」と警告', '古いAPIや機能を「今後廃止予定」としてマークし、新しい方法への移行を促すこと。', 'ドキュメントやレスポンスヘッダーで警告。一定期間後に実際に削除する。', '閉店予告。「来月でこの店は閉めます。隣の新店舗をご利用ください」という告知。', '非推奨APIを使い続けるのは危険。移行期間中に新しいAPIに切り替える。', ARRAY['versioning', 'migration', 'backward-compatibility'], '「Deprecation は、古いやり方の廃止予告です」'),

  ('idempotent', 'Idempotent', '冪等（べきとう）', 16, 42, 2, '何度実行しても結果が同じ', '同じリクエストを何度送っても、結果が変わらない性質。GET、PUT、DELETEは冪等、POSTは非冪等。', 'DELETE /users/123 を何度送っても、結果は「ID123が削除された状態」で同じ。', '電気のスイッチを「切」にする。何度押しても、結果は「切」のまま。', '冪等でない操作のリトライは注意。重複処理を防ぐ仕組みが必要。', ARRAY['http-methods', 'get-method', 'post'], '「Idempotent は、何度やっても結果が同じという性質です」'),

  ('retry', 'Retry', 'リトライ', 16, 43, 1, '失敗したら再試行する', 'APIリクエストが失敗した場合に、自動的に再試行する仕組み。一時的な障害に対応。', '指数バックオフ（1秒、2秒、4秒…と間隔を空ける）で再試行。最大回数を設定。', '電話が話し中だったらかけ直す。一度失敗しても、少し待ってもう一度試す。', 'リトライしすぎるとサーバーに負荷。最大回数と間隔を適切に設定。', ARRAY['error', 'timeout', 'resilience'], '「Retry は、失敗しても諦めずにもう一度試すことです」'),

  ('fallback', 'Fallback', 'フォールバック', 16, 44, 2, '失敗時の代替手段', '主要な方法が失敗した場合に使用する代替手段。キャッシュを返す、デフォルト値を使うなど。', 'try-catchでエラーを捕捉し、エラー時にfallbackの処理を実行。', '非常口。普段の出口が使えないとき、代わりに使える別のルート。', 'fallbackも失敗することがある。多重のfallback戦略を用意する。', ARRAY['error-handling', 'retry', 'resilience'], '「Fallback は、うまくいかないときの代替案です」'),

  ('api-documentation', 'API Documentation', 'APIドキュメント', 16, 45, 1, 'APIの使い方を説明する文書', 'APIのエンドポイント、パラメータ、レスポンス形式、認証方法などを説明する文書。Swagger/OpenAPIで自動生成も可能。', 'エンドポイント一覧、リクエスト/レスポンス例、エラーコード、認証方法などを記載。', '取扱説明書。製品（API）の使い方が詳しく書いてある。', 'ドキュメントとAPIの実装を同期させる。乖離があると混乱の元。', ARRAY['api', 'swagger', 'openapi'], '「API Documentation は、外交手続きの説明書です。これが旅の最後の用語です」')

ON CONFLICT (id) DO UPDATE SET
  term = EXCLUDED.term,
  term_ja = EXCLUDED.term_ja,
  chapter_id = EXCLUDED.chapter_id,
  order_index = EXCLUDED.order_index,
  difficulty = EXCLUDED.difficulty,
  one_liner = EXCLUDED.one_liner,
  definition = EXCLUDED.definition,
  mechanism = EXCLUDED.mechanism,
  analogy = EXCLUDED.analogy,
  pitfall = EXCLUDED.pitfall,
  related_terms = EXCLUDED.related_terms,
  story_context = EXCLUDED.story_context;