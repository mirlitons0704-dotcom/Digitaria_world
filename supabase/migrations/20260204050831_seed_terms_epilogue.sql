/*
  # Seed Epilogue Terms - メモリーガーデン

  1. Content
    - Seeds 20 programming terms for the Epilogue (Chapter 17 - Memory Garden)
    - Topics include: Error handling, CSS layout, deployment, and web fundamentals
    - This completes the 500-term journey + 20 bonus terms = 520 total

  2. Terms Added (20 total)
    - Try/catch, Null/Undefined, Optional chaining, Nullish coalescing
    - Template literal, Ternary operator, localStorage
    - Flexbox, Grid (CSS), z-index, Box model
    - Responsive design, Breakpoint (CSS), Status code
    - Deploy, Hosting, Domain, SSL/HTTPS
    - SEO, Accessibility
*/

INSERT INTO terms (id, term, term_ja, chapter_id, order_index, difficulty, one_liner, definition, mechanism, analogy, pitfall, related_terms, story_context)
VALUES
  ('try-catch', 'Try/catch', 'トライキャッチ', 17, 1, 1, 'エラーを捕まえて対処する構文', 'エラーが発生する可能性のあるコードを try で囲み、エラーが起きたら catch で捕まえて処理する構文。', 'try { 危険なコード } catch (error) { エラー時の処理 } の形式。finally で後処理も可能。', '安全ネット。サーカスの空中ブランコで、落ちても（エラーでも）ネット（catch）が受け止める。', '全てを try/catch で囲むのではなく、エラーが起きうる箇所に適切に使う。', ARRAY['error', 'exception', 'async'], '最初の蝶が舞い降りて教えてくれた。「失敗を恐れないで。Try/catch があれば大丈夫」'),

  ('null-undefined', 'Null / Undefined', 'ヌル / アンディファインド', 17, 2, 1, '「何もない」を表す2つの値', 'null は「意図的に空」、undefined は「まだ値が入っていない」を表す。似ているが意味が異なる。', 'let x; は undefined。let y = null; は意図的に空。typeof null は ''object''（歴史的バグ）。', '空の箱（null）と、箱がまだない（undefined）の違い。', '== では null == undefined は true。=== では false。厳密等価を使う。', ARRAY['variable', 'typeof', 'optional-chaining'], '「『ない』にも種類があるんだよ。それを知ることが大切」'),

  ('optional-chaining', 'Optional chaining', 'オプショナルチェイニング', 17, 3, 2, '安全にプロパティにアクセスする (?.) 構文', 'オブジェクトのプロパティが存在しない可能性があるとき、エラーを起こさずに安全にアクセスする構文。', 'user?.address?.city は、途中が null/undefined でもエラーにならず undefined を返す。', '慎重なノック。「いますか？」と確認しながら、部屋を順番に訪ねていく。', '存在チェックに便利だが、使いすぎるとバグを隠してしまうことも。', ARRAY['null-undefined', 'nullish-coalescing', 'object'], '「道が途切れていても、?.があれば転ばないよ」'),

  ('nullish-coalescing', 'Nullish coalescing', 'ヌリッシュコアレッシング', 17, 4, 2, 'null/undefined のときだけ代替値を使う (??) 演算子', '左辺が null または undefined のときだけ右辺の値を使う演算子。|| とは異なり、0 や '''' は有効な値として扱う。', 'value ?? ''default'' は、value が null/undefined のときだけ ''default'' を返す。', '「本当に空っぽのときだけ」予備を使う。0円は「ある」、未設定は「ない」。', '|| は falsy 全体（0, '''', false も）で代替される。?? は null/undefined だけ。', ARRAY['null-undefined', 'optional-chaining', 'ternary-operator'], '「『ない』ときだけ代わりを使う、賢い選択だね」'),

  ('template-literal', 'Template literal', 'テンプレートリテラル', 17, 5, 1, 'バッククォートで変数を埋め込める文字列', 'バッククォート（`）で囲み、${} で変数や式を埋め込める文字列。複数行もそのまま書ける。', '`Hello, ${name}!` のように使用。+ で連結するより読みやすい。', '穴埋め問題。「こんにちは、___さん」の空欄に、自動で名前が入る。', 'バッククォート（`）とシングルクォート（''）を間違えないよう注意。', ARRAY['string', 'variable', 'es6'], '「文字と変数を、自然につなげる魔法だよ」'),

  ('ternary-operator', 'Ternary operator', '三項演算子', 17, 6, 1, '条件 ? 真の値 : 偽の値', '条件式を1行で書ける演算子。条件が true なら最初の値、false なら2番目の値を返す。', 'isLoggedIn ? ''Welcome'' : ''Please login'' のように使用。if-else の短縮形。', '二択クイズ。「正解ならA、不正解ならB」を一言で表現。', 'ネストすると読みにくくなる。複雑な条件は if-else を使う。', ARRAY['conditional-rendering', 'if-else', 'jsx'], '「二択なら、この書き方がスマートだよ」'),

  ('localstorage', 'localStorage', 'ローカルストレージ', 17, 7, 1, 'ブラウザにデータを永続保存', 'ブラウザにキーと値のペアでデータを保存する仕組み。ブラウザを閉じても消えない。', 'localStorage.setItem(''key'', ''value'') で保存、getItem(''key'') で取得。文字列のみ保存可能。', 'ブラウザの引き出し。入れたものは、ブラウザを閉じても残っている。', 'オブジェクトは JSON.stringify() で文字列化して保存。取り出すときは JSON.parse()。', ARRAY['cookie', 'session', 'json'], '「大切なものは、ここに預けておけるよ」'),

  ('flexbox', 'Flexbox', 'フレックスボックス', 17, 8, 1, '要素を柔軟に並べるCSSレイアウト', '要素を横並びや縦並びにし、間隔や配置を柔軟に調整できるCSSレイアウト方式。', 'display: flex; で有効化。justify-content、align-items で配置を制御。', '整列するダンサー。「横に並んで」「中央に集まって」と指示できる。', 'flexは1次元（横か縦）。2次元のレイアウトには Grid を使う。', ARRAY['grid-css', 'css', 'layout'], '「要素を自由自在に並べる、便利な魔法だよ」'),

  ('grid-css', 'Grid (CSS)', 'グリッド（CSS）', 17, 9, 2, '2次元のグリッドレイアウト', '行と列の2次元グリッドで要素を配置するCSSレイアウト方式。複雑なレイアウトに最適。', 'display: grid; で有効化。grid-template-columns、grid-template-rows で格子を定義。', 'エクセルのセル。縦横に区切られたマス目に、要素を配置していく。', 'Flexboxと使い分ける。1次元はFlex、2次元はGridが得意。', ARRAY['flexbox', 'css', 'layout'], '「縦と横、両方を操る上級魔法だね」'),

  ('z-index', 'z-index', 'ゼットインデックス', 17, 10, 1, '要素の重なり順を指定する', '要素が重なったときの前後関係（奥行き）を指定するCSSプロパティ。値が大きいほど前面に。', 'z-index: 100; のように指定。position が static 以外でないと効かない。', '紙の重ね順。z-index が大きい紙が一番上に来る。', 'z-index の値がインフレしがち。9999 より、計画的な値（10, 20, 30...）を使う。', ARRAY['modal', 'overlay', 'position'], '「どの要素が前に来るか、この数字で決まるんだ」'),

  ('box-model', 'Box model', 'ボックスモデル', 17, 11, 1, '要素を構成する4つの領域', '全てのHTML要素は、content（内容）、padding（内側余白）、border（枠線）、margin（外側余白）の4層で構成される。', 'box-sizing: border-box; にすると、width に padding と border が含まれる。', 'プレゼントの箱。中身（content）→ 緩衝材（padding）→ 箱（border）→ 他の箱との間隔（margin）。', 'デフォルトは content-box。border-box の方が計算しやすいので、リセットCSSで設定することが多い。', ARRAY['css', 'margin', 'padding'], '「全ての要素は、この4つの層でできているんだよ」'),

  ('responsive-design', 'Responsive design', 'レスポンシブデザイン', 17, 12, 1, '画面サイズに応じてレイアウトを変える', 'PC、タブレット、スマホなど、様々な画面サイズに対応してレイアウトが変化するデザイン手法。', 'メディアクエリ（@media）でブレークポイントを設定。Tailwind なら md:、lg: などのプレフィックス。', '水のように形を変える。容器（画面）に合わせて、自然に形を変える。', 'モバイルファーストで設計すると、後から大画面対応がしやすい。', ARRAY['breakpoint-css', 'media-query', 'mobile'], '「どんな画面でも美しく。それがレスポンシブの心だよ」'),

  ('breakpoint-css', 'Breakpoint (CSS)', 'ブレークポイント（CSS）', 17, 13, 1, 'レイアウトが切り替わる画面幅', 'レスポンシブデザインでレイアウトが変化する境界となる画面幅。640px、768px、1024px などが一般的。', '@media (min-width: 768px) { } でタブレット以上にスタイルを適用。', '変身ポイント。この幅を超えると、レイアウトが変身する。', 'デバッグ時のbreakpoint（デバッガー）と混同しないよう注意。文脈で判断。', ARRAY['responsive-design', 'media-query', 'tailwind'], '「この境界を越えると、レイアウトが変わるんだ」'),

  ('status-code', 'Status code (404/500)', 'ステータスコード', 17, 14, 1, 'HTTPレスポンスの結果を示す数字', 'サーバーからのレスポンスの結果を示す3桁の数字。200（成功）、404（見つからない）、500（サーバーエラー）など。', '1xx: 情報、2xx: 成功、3xx: リダイレクト、4xx: クライアントエラー、5xx: サーバーエラー。', '診断結果。「健康（200）」「見つかりません（404）」「こちらの問題です（500）」。', '4xxはクライアント側、5xxはサーバー側の問題。原因の切り分けに使う。', ARRAY['http', 'request', 'response'], '「この数字で、何が起きたかわかるんだよ」'),

  ('deploy', 'Deploy', 'デプロイ', 17, 15, 1, 'アプリを本番環境に公開する', '開発したアプリケーションを本番サーバーに配置し、ユーザーがアクセスできる状態にすること。', 'ビルド → サーバーにアップロード → 公開。Vercel、Netlify などは Git push で自動デプロイ。', 'お店のオープン。準備が終わって、いよいよお客さんを迎える。', 'デプロイ前にテストを十分に。本番で問題が起きると影響が大きい。', ARRAY['hosting', 'production-environment', 'ci-cd'], '「作ったものを世界に届ける、最後の一歩だよ」'),

  ('hosting', 'Hosting', 'ホスティング', 17, 16, 1, 'Webサイトを公開するサービス', 'Webサイトやアプリケーションをインターネット上で公開するためのサーバーサービス。', 'Vercel、Netlify、AWS、さくらサーバーなど。静的サイト向け、動的サイト向けなど種類がある。', '店舗の場所を借りる。自分の商品（サイト）を置いて、お客さんに来てもらう場所。', '無料プランには制限がある。トラフィックや機能に応じて有料プランを検討。', ARRAY['deploy', 'domain', 'server'], '「君のアプリが住む場所、それがホスティングだよ」'),

  ('domain', 'Domain', 'ドメイン', 17, 17, 1, 'Webサイトの住所（URL）', 'example.com のような、Webサイトを特定するための人間が読みやすい名前。IPアドレスの代わりに使う。', 'DNSがドメイン名をIPアドレスに変換。独自ドメインは購入して設定する。', 'お店の看板。住所（IP）より、名前（ドメイン）の方が覚えやすい。', 'ドメインは早い者勝ち。欲しい名前は早めに取得する。年間更新費用がかかる。', ARRAY['dns', 'hosting', 'url'], '「君のアプリの名前、世界に一つだけの住所だよ」'),

  ('ssl-https', 'SSL / HTTPS', 'エスエスエル / エイチティーティーピーエス', 17, 18, 1, '通信を暗号化して安全にする', 'SSL（TLS）証明書を使って通信を暗号化するプロトコル。URLが https:// で始まる。鍵マークが表示される。', 'サーバーとブラウザ間の通信を暗号化。盗聴や改ざんを防ぐ。Let''s Encrypt で無料取得可能。', '暗号化された手紙。途中で誰かに見られても、内容は読めない。', '現代のWebでは HTTPS は必須。HTTP だと「安全ではありません」と警告が出る。', ARRAY['security', 'http', 'certificate'], '「通信を守る鍵、それがSSLの役目だよ」'),

  ('seo', 'SEO', 'エスイーオー', 17, 19, 1, '検索エンジンで上位表示を目指す', 'Search Engine Optimizationの略。Google などの検索結果で上位に表示されるようにサイトを最適化すること。', '適切なタイトル、メタディスクリプション、構造化データ、高速表示、モバイル対応などが重要。', 'お店を見つけやすくする工夫。看板を目立たせ、地図に正しく載せる。', 'SEOのためにユーザー体験を犠牲にしない。良いコンテンツが最も重要。', ARRAY['metadata', 'html', 'performance'], '「見つけてもらうための工夫、それがSEOだよ」'),

  ('accessibility', 'Accessibility', 'アクセシビリティ', 17, 20, 1, '誰もが使えるようにする配慮', '障害の有無に関わらず、すべての人がWebサイトやアプリを利用できるようにする取り組み。a11y と略される。', 'セマンティックHTML、ARIA属性、キーボード操作対応、色のコントラスト、altテキストなど。', 'バリアフリー。車椅子の人も、目が見えにくい人も、誰もが入れる建物を作る。', 'アクセシビリティは最後に対応するのではなく、最初から意識して設計する。', ARRAY['semantic-html', 'aria', 'focus-state'], '最後の蝶が舞い降りて言った。「すべての人のために作る。それが、本当に美しいコードだよ」')

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