/*
  # Seed Story Scenes for Chapters 7-11

  Chapter 7: JavaScript道場 (10 scenes, guide: JSマスター)
  Chapter 8: コンポーネント学園 (9 scenes, guide: リアクト先生)
  Chapter 9: UIパーツ工房 (8 scenes, guide: UIデザイナー・ミア)
  Chapter 10: デザインの美術館 (10 scenes, guide: UIデザイナー・ミア)
  Chapter 11: スタイルの仕立て屋 (8 scenes, guide: テイル職人)
*/

-- =============================================
-- Chapter 7: JavaScript道場
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (7, 1, '道場への入門',
   E'港を離れ、山の上の道場に着いた。「JavaScript道場」と書かれた門がある。\n\n「ここで Web に動きを加える術を学ぶんだ」とビットくん。\n\n白髪の師範が出迎えた。\n\n「ようこそ。私は JS マスター。JavaScript（ジャバスクリプト）の奥義を伝授しよう」\n\n「JavaScript は Web ページに命を吹き込む言語だ。ボタンをクリックしたら何かが起きる、そういう動きを作れる」\n\n「TypeScript（タイプスクリプト）は、JavaScript に『型』を加えた改良版。より安全にコードが書ける」',
   ARRAY['javascript', 'typescript'],
   ARRAY['11111111-1111-1111-1111-111111111111', '99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 2, '変数の術',
   E'「ES6（イーエスシックス）は、2015年に登場した JavaScript の大きなアップデートだ」\n\n「ECMAScript（エクマスクリプト）は JavaScript の正式名称。ES6 は正確には ECMAScript 2015 のことだ」\n\n「Let と Const は、変数を宣言する術」\n\n「Arrow function（アロー関数）は、関数を短く書く新しい書き方だ」\n\n「=> の形が矢印（アロー）に見えるだろう」',
   ARRAY['es6', 'ecmascript', 'let', 'const', 'arrow-function'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 3, '非同期の術',
   E'「Web では『待つ』処理が多い。データを取ってくる間、止まっていては困るだろう」\n\n「Promise（プロミス）は、『将来の結果を約束する』仕組みだ」\n\n「Async/Await（アシンク/アウェイト）は、Promise を読みやすく書く術」\n\n「Fetch（フェッチ）は、サーバーからデータを取得する術」\n\n「Then/catch は Promise を扱う従来の書き方だ」',
   ARRAY['promise', 'async', 'await', 'fetch', 'then-catch'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 4, '便利な記法',
   E'「ES6 で追加された便利な記法を教えよう」\n\n「Spread operator（スプレッド演算子）は、配列やオブジェクトを展開する」\n\n「Destructuring（分割代入）は、配列やオブジェクトから値を取り出す」\n\n「これらを使いこなせば、コードがぐっと短くなる」',
   ARRAY['spread-operator', 'destructuring'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 5, 'モジュールの術',
   E'「大きなプログラムは Module（モジュール）に分ける」\n\n「Import は他のファイルから取り込む」\n「Export は他のファイルに公開する」\n\n「Default export（デフォルトエクスポート）はファイルの主役を1つだけ公開」\n\n「Named export（名前付きエクスポート）は複数の機能を名前をつけて公開」\n\n「Barrel exports は、複数のモジュールを1箇所にまとめて再エクスポートする技だ」\n\n「Library import（ライブラリインポート）で便利な外部ライブラリも使える」',
   ARRAY['module', 'import', 'export', 'default-export', 'named-export', 'barrel-exports', 'library-import'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 6, 'イベントの術',
   E'「Event（イベント）は、何かが起きたときの知らせだ」\n\n「クリック、キー入力、スクロール……ユーザーの操作はすべてイベントになる」\n\n「Event listener（イベントリスナー）は、イベントを監視する見張り番」\n\n「Event handler（イベントハンドラー）は、イベントが起きたときの処理内容」\n\n「Prevent default（プリベントデフォルト）は、ブラウザの標準動作を止める術」\n\n「This keyword は、今どのオブジェクトを指しているかを表す。文脈によって変わるので注意が必要だ」',
   ARRAY['event', 'event-listener', 'event-handler', 'prevent-default', 'this-keyword'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 7, 'タイマーの術',
   E'「時間を操る術もある」\n\n「setTimeout は、指定時間後に1回だけ実行」\n\n「setInterval は、指定間隔で繰り返し実行」\n\n「Web ページで時計を動かしたり、定期的にデータを取得したりできる」',
   ARRAY['settimeout', 'setinterval'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 8, '配列操作の術',
   E'「配列を操る強力な術を教えよう」\n\n「Map function（マップ関数）は、全要素を変換して新しい配列を作る」\n\n「Filter function（フィルター関数）は、条件に合う要素だけを抽出」\n\n「Reduce function（リデュース関数）は、全要素を1つの値にまとめる」\n\n「ForEach は全要素に処理を実行」\n「Find は条件に合う最初の要素を返す」\n\n「これらを組み合わせれば、複雑なデータ処理も簡潔に書ける」',
   ARRAY['map-function', 'filter-function', 'reduce-function', 'foreach', 'find'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 9, 'デバッグの術',
   E'「Console log（コンソールログ）は、デバッグの基本中の基本だ」\n\n「Get は値を取得すること、Typeof は型を確認する術だ」\n\n「Parsing（パージング）は、文字列を解析してデータに変換すること」\n\n「Zod は TypeScript でデータの形を検証するライブラリだ」\n\n「Utility（ユーティリティ）は、便利な補助関数のことだ」',
   ARRAY['console-log', 'get', 'typeof', 'parsing', 'zod', 'utility'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[]),

  (7, 10, 'Node.js',
   E'「JavaScript はブラウザの中だけでなく、サーバーでも動かせる」\n\n「Node.js（ノードジェイエス）は、JavaScript をサーバーで動かす環境だ」\n\n「これのおかげで、フロントエンドもバックエンドも JavaScript で書けるようになった」\n\n「次の章では React を学ぶ。JavaScript の知識を活かして、もっと複雑な UI を作れるようになるぞ」\n\n「ありがとうございました、師匠！」',
   ARRAY['node-js'],
   ARRAY['99999999-9999-9999-9999-999999999999']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 8: コンポーネント学園
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (8, 1, '学園の門',
   E'山を下りると、モダンな校舎が見えてきた。\n\n「コンポーネント学園へようこそ！」\n\n若い女性教師が出迎えた。\n\n「私はリアクト先生。React（リアクト）という UI構築ライブラリを教えています」\n\n「React は Facebook が作った人気のライブラリです。UI を『部品』に分けて作るのが特徴よ」\n\n「React component（コンポーネント）がその『部品』のこと。小さな部品を組み合わせて、大きな画面を作っていくの」',
   ARRAY['react', 'react-component'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 2, 'コンポーネントの基本',
   E'「Functional component（関数コンポーネント）が現在の主流よ」\n\n「JSX（ジェイエスエックス）は、JavaScript の中に HTML のような記法を書ける仕組み」\n\n「TSX は TypeScript 版の JSX よ」\n\n「見た目は HTML みたいだけど、実際は JavaScript なの」\n\n「class ではなく className を使うのが JSX のルールよ」',
   ARRAY['functional-component', 'jsx', 'tsx'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 3, 'データの受け渡し',
   E'「Props（プロップス）は、親から子へデータを渡す方法よ」\n\n「Children prop（チルドレンプロップ）は、タグの中身を渡す特別な Props よ」\n\n「State（ステート）は、コンポーネント自身が持つ変化するデータのこと」\n\n「Local state（ローカルステート）はそのコンポーネントだけのデータ、Global state（グローバルステート）はアプリ全体で共有するデータよ」',
   ARRAY['props', 'children-prop', 'state', 'local-state', 'global-state'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 4, 'フックの魔法',
   E'「Hook（フック）は、関数コンポーネントに機能を追加する魔法よ」\n\n「useState は State を使うフック」\n\n「useEffect は Side effect（副作用）——データ取得や購読などを扱うフック」\n\n「Dependency array（依存配列）は、useEffect がいつ実行されるかを決める」\n\n「useRef は値を保持するフック。DOM要素への参照にも使うわ」\n\n「useMemo と useCallback は Memoization（メモ化）のフック。不要な再計算を防ぐの」',
   ARRAY['hook', 'usestate', 'useeffect', 'side-effect', 'dependency-array', 'useref', 'usememo', 'usecallback', 'memoization'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 5, 'ライフサイクル',
   E'「コンポーネントには Lifecycle（ライフサイクル）があるの」\n\n「Mount（マウント）は、コンポーネントが画面に表示されるとき」\n\n「Unmount（アンマウント）は、画面から消えるとき」\n\n「Render（レンダー）は、コンポーネントが画面を描画すること」\n\n「Re-render（再レンダー）は、State や Props が変わって描き直すこと」\n\n「Virtual DOM（仮想DOM）は、React の高速化の秘密。実際のDOMを直接触らず、仮想的なコピーで差分を計算するの」\n\n「変わった部分だけを更新するから、とても効率的なのよ」',
   ARRAY['lifecycle', 'mount', 'unmount', 'render', 're-render', 'virtual-dom'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 6, '条件とリスト',
   E'「Conditional rendering（条件付きレンダー）は、条件によって表示を変えること」\n\n「List rendering（リストレンダー）は、配列のデータを繰り返し表示すること」\n\n「Key prop（キープロップ）は、リストの各要素につけるユニークな識別子よ」\n\n「これがないと React がどの要素が変わったか判断できないの」\n\n「Fragment（フラグメント）は、余計な要素を追加せずにまとめる方法」',
   ARRAY['conditional-rendering', 'list-rendering', 'key-prop', 'fragment'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 7, '状態管理',
   E'「アプリが大きくなると、State management（状態管理）が重要になるわ」\n\n「Prop drilling（プロップドリリング）は、何層も Props をバケツリレーする問題」\n\n「解決策のひとつが Context よ」\n\n「Context（コンテキスト）は、Props を使わずにデータを共有する仕組み」\n\n「Context provider（プロバイダー）でデータを提供して、useContext で受け取るの」\n\n「Reducer（リデューサー）と useReducer は、複雑な状態変更をまとめて管理する方法」\n\n「State store（ステートストア）は、状態を一箇所にまとめて管理する場所よ」\n\n「Lifting state（ステートの持ち上げ）は、共通の親に State を移動させること」',
   ARRAY['state-management', 'prop-drilling', 'context', 'context-provider', 'usecontext', 'reducer', 'usereducer', 'state-store', 'lifting-state'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 8, 'カスタムフック',
   E'「Custom hook（カスタムフック）は、自分で作るオリジナルのフックよ」\n\n「ロジックを再利用できるのがカスタムフックの魅力よ」\n\n「フック名は必ず use で始めること。これが React のルールよ」',
   ARRAY['custom-hook'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[]),

  (8, 9, '制御されたコンポーネント',
   E'「Controlled component（制御されたコンポーネント）は、フォーム要素の値を State で管理すること」\n\n「入力値を React が完全にコントロールするの。バリデーションなどがしやすくなるわ」\n\n「これで React の基礎は完璧よ！」\n\n「次は UI コンポーネントのパターンを学びに行きましょう」',
   ARRAY['controlled-component'],
   ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 9: UIパーツ工房
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (9, 1, 'UIパーツ工房へ',
   E'学園を出ると、色とりどりの部品が並ぶ工房が見えてきた。\n\n「ここは UIパーツ工房よ！」\n\n華やかな女性が出迎えた。\n\n「私は UIデザイナーのミア。使いやすい部品を作る方法を教えるわ」\n\n「Page（ページ）は画面全体、Component（コンポーネント）はその中の部品よ」\n\n「Header（ヘッダー）はページの上部、Footer（フッター）は下部」\n\n「Navbar（ナビバー）はナビゲーションメニュー、Sidebar（サイドバー）は横に配置する補助メニュー」\n\n「Layout（レイアウト）は、これらの配置パターンのこと。Navigation（ナビゲーション）は、ページ間を移動する仕組みね」',
   ARRAY['page', 'component', 'layout', 'layouts', 'ui-header', 'footer', 'navbar', 'sidebar', 'navigation'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 2, 'カードとボタン',
   E'「Card（カード）は、情報をまとめて表示する箱よ」\n\nミアさんがサンプルを見せた。\n\n「SNSの投稿、商品一覧、プロフィール表示……カードはどこでも使われるわ」\n\n「Button（ボタン）は、クリックして何かを実行する部品」\n\n「押せることがひと目でわかるデザインが大切よ」',
   ARRAY['card', 'button'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 3, 'フォームの部品たち',
   E'「Form（フォーム）は、ユーザーが情報を入力する場所よ」\n\n「Input field（入力フィールド）はテキストを入力する箱」\n\n「Label（ラベル）は、何を入力するか示すテキスト」\n\n「Placeholder（プレースホルダー）は、入力欄に薄く表示されるヒント」\n\n「Validation（バリデーション）は、入力内容が正しいかチェックすること」\n\n「Error message（エラーメッセージ）は、入力に問題があるとき表示する警告」\n\n「Submit（サブミット）は、フォームの内容を送信すること。送信ボタンを押すと実行されるわ」',
   ARRAY['form', 'input-field', 'label', 'placeholder', 'validation', 'error-message', 'submit'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 4, '選択する部品たち',
   E'「選ぶための部品もいろいろあるの」\n\n「Checkbox（チェックボックス）は、複数選択できる四角いボタン」\n\n「Radio button（ラジオボタン）は、ひとつだけ選べる丸いボタン」\n\n「Select（セレクト）は、ドロップダウンで選ぶ部品」\n\n「Dropdown menu（ドロップダウンメニュー）は、クリックすると開く選択肢のリスト」\n\n「Toggle（トグル）は、ON/OFFを切り替えるスイッチ」\n\n「Slider（スライダー）は、つまみを動かして値を選ぶ部品」',
   ARRAY['checkbox', 'radio-button', 'select', 'dropdown-menu', 'toggle', 'slider'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 5, 'お知らせの部品たち',
   E'「ユーザーに何かを伝える部品も大切よ」\n\n「Alert（アラート）は、重要なお知らせを目立たせる表示」\n\n「Notification（通知）は、新しい情報を知らせる表示」\n\n「Toast（トースト）は、画面の隅にポッと出てきて自動で消える短いお知らせ」\n\n「パンがトースターからポンと出てくるイメージね」\n\n「Tooltip（ツールチップ）は、要素にマウスを乗せると出てくる小さな説明。Tool tips とも呼ぶわ」',
   ARRAY['alert', 'notification', 'toast', 'tooltip', 'tool-tips'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 6, '重ねて表示する部品',
   E'「Modal（モーダル）は、画面の上に重ねて表示するウィンドウ」\n\n「Dialog box（ダイアログボックス）とも呼ぶわ。確認メッセージや入力フォームに使うの」\n\n「Popup（ポップアップ）も似ているけど、もっと小さな表示に使うことが多いわ」\n\n「Overlay（オーバーレイ）は、背景を暗くしてモーダルを目立たせる効果よ」\n\n「オーバーレイをクリックするとモーダルが閉じる、という動作もよく使われるパターンよ」',
   ARRAY['modal', 'dialog-box', 'popup', 'overlay'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 7, '待機と読み込み',
   E'「データを読み込んでいる間も、ユーザーを待たせっぱなしにしないの」\n\n「Spinner（スピナー）は、くるくる回る読み込み中の表示」\n\n「Progress bar（プログレスバー）は、どれくらい進んだか示すバー」\n\n「Skeleton loader（スケルトンローダー）は、コンテンツの形をした灰色のプレースホルダーよ」\n\n「何が表示されるかイメージできるから、待ち時間が短く感じるのよ」',
   ARRAY['spinner', 'progress-bar', 'skeleton-loader'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (9, 8, '整理する部品たち',
   E'「情報を整理して表示する部品も紹介するわ」\n\n「Accordion（アコーディオン）は、クリックすると開閉する折りたたみ式」\n\n「FAQでよく使われるわ」\n\n「Tab（タブ）/ Tabs は、同じ場所で内容を切り替える部品」\n\n「Pagination（ページネーション）は、コンテンツを複数ページに分けてナビゲーションを表示する仕組み」',
   ARRAY['accordion', 'tab', 'tabs', 'pagination'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 10: デザインの美術館
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (10, 1, '美術館への招待',
   E'工房を出ると、白い大理石の建物が見えてきた。\n\n「ここは『デザインの美術館』よ」\nミアさんが案内してくれた。\n\n「この章では UI/UX について学ぶわ」\n\n「UI は User interface（ユーザーインターフェース）——ユーザーが触れる画面や部品のこと」\n\n「UX は User experience（ユーザーエクスペリエンス）——ユーザーが感じる体験全体のこと」\n\n「見た目の美しさ（UI）と、使いやすさ（UX）の両方が大切なの」',
   ARRAY['ui-ux', 'user-interface', 'user-experience'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 2, '設計の工程',
   E'最初の展示室には、設計図が並んでいた。\n\n「Wireframe（ワイヤーフレーム）は、ページの骨組みだけを描いた設計図」\n\n「色やデザインは省いて、配置だけを考えるの」\n\n「Mockup（モックアップ）は、色やフォントを入れた完成イメージに近いデザイン」\n\n「ワイヤーフレーム → モックアップ → 実装という流れで進めることが多いわ」',
   ARRAY['wireframe', 'mockup'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 3, 'デザインシステム',
   E'「Design system（デザインシステム）は、デザインのルールをまとめたもの」\n\n「色、フォント、余白、ボタンのスタイル……すべて統一することで、ブランドの一貫性を保てるの」\n\n「Component library（コンポーネントライブラリ）は、再利用できる部品の集まり」\n\n「Design tokens（デザイントークン）は、色やサイズを変数として定義したもの」\n\n「Theme（テーマ）は、デザインの全体的な雰囲気のこと」\n\n「Light mode（ライトモード）は明るい背景、Dark mode（ダークモード）は暗い背景。最近は両方用意するのが主流ね」',
   ARRAY['design-system', 'component-library', 'design-tokens', 'theme', 'light-mode', 'dark-mode'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 4, '色の世界',
   E'次の展示室は、虹のような色彩に満ちていた。\n\n「Color scheme（カラースキーム）は、サイト全体の配色計画よ」\n\n「Hex color（16進数カラー）は # から始まる6桁の英数字」\n\n「RGB は赤・緑・青の3つの値で色を表す」\n\n「Opacity（オパシティ）は透明度。0が完全に透明、1が完全に不透明」',
   ARRAY['color-scheme', 'hex-color', 'rgb', 'opacity'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 5, '文字の美しさ',
   E'「Typography（タイポグラフィ）は、文字のデザインを扱う分野よ」\n\n「Font（フォント）は書体のこと」\n\n「Font family（フォントファミリー）は、使用するフォントの指定」\n\n「Font size（フォントサイズ）は文字の大きさ、Font weight（フォントウェイト）は太さ」\n\n「Line height（ラインハイト）は行の高さ。1.5〜1.8くらいが読みやすいわ」\n\n「Google Fonts は、無料で使えるフォントの宝庫よ。Web サイトで簡単に使えるの」',
   ARRAY['typography', 'font', 'font-family', 'font-size', 'font-weight', 'line-height', 'google-fonts'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 6, 'アイコンと画像',
   E'「Icon（アイコン）は、意味を伝える小さな絵よ」\n\n「Lucide dev icons は、人気のあるアイコンライブラリ」\n\n「Favicon（ファビコン）は、ブラウザのタブに表示される小さなアイコン」\n\n「Pexels は、無料で商用利用できる写真素材サイトよ」\n\n「More options icon（もっと見るアイコン）は、⋮ や … のようなメニューを開くアイコン」\n\n「Home（ホーム）は、サイトのトップページを指すわ」\n\n「QR code（QRコード）は、スマホで読み取るとURLなどに飛べる四角いコードよ」',
   ARRAY['icon', 'lucide-dev-icons', 'favicon', 'pexels', 'more-options-icon', 'home', 'qr-code'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 7, '状態のデザイン',
   E'「部品には様々な『状態』があるの」\n\n「Hover state（ホバー状態）は、マウスを乗せたときの見た目」\n\n「Active state（アクティブ状態）は、クリック中の見た目」\n\n「Focus state（フォーカス状態）は、キーボードで選択したときの見た目。アクセシビリティに重要よ」\n\n「Disabled state（無効状態）は、操作できないときの見た目。グレーアウトすることが多いわ」',
   ARRAY['hover-state', 'active-state', 'focus-state', 'disabled-state'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 8, '装飾と効果',
   E'「デザインを豊かにする装飾テクニックよ」\n\n「Drop shadow（ドロップシャドウ）は、要素に影をつけて浮いているように見せる」\n\n「Border radius（ボーダーラディウス）は、角を丸くする設定」\n\n「Gradient（グラデーション）は、色が徐々に変化する効果」\n\n「これらを組み合わせると、立体感や奥行きが生まれるの」',
   ARRAY['drop-shadow', 'border-radius', 'gradient'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 9, '動きの魔法',
   E'「Animations（アニメーション）は、要素に動きをつけること」\n\n「Transition（トランジション）は、状態が変わるときの滑らかな変化」\n\n「ホバーしたとき、ふわっと色が変わる——そんな心地よい動きを作れるわ」\n\n「でも、やりすぎは禁物よ。動きが多すぎると疲れるし、酔う人もいるの」\n\n「アニメーションは『スパイス』のようなもの。適量が大切ね」',
   ARRAY['animations', 'transition'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[]),

  (10, 10, 'レイアウトの基本',
   E'「最後に、レイアウトの基本用語を」\n\n「Row（ロウ）は横の行、Column（コラム）は縦の列」\n\n「グリッドシステムでは、この行と列を組み合わせてレイアウトを作るの」\n\n「デザインの基本を学んだわね。次は、CSS フレームワークで効率よくスタイリングする方法を学びましょう」',
   ARRAY['row', 'column'],
   ARRAY['bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 11: スタイルの仕立て屋
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (11, 1, '仕立て屋の店',
   E'美術館を出ると、おしゃれな仕立て屋の店が見えた。\n\n「いらっしゃい！私はテイル職人。CSS を効率よく書く技術を教えるよ」\n\n「CSS は自由度が高い分、大きなプロジェクトでは管理が大変になるんだ」\n\n「そこで登場するのが CSS フレームワークや様々なスタイリング手法さ」',
   ARRAY[]::text[],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 2, 'Tailwind CSS',
   E'「Tailwind（テイルウィンド）は、今最も人気のある CSS フレームワークだ」\n\n「Utility-first（ユーティリティファースト）という考え方に基づいている」\n\n「小さなクラスを組み合わせてスタイルを作るんだ」\n\n「CSS ファイルを別に書かなくても、HTML の中でスタイリングが完結する」\n\n「慣れると爆速で開発できるよ！」',
   ARRAY['tailwind', 'utility-first'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 3, 'コンポーネントライブラリ',
   E'「Shadcn（シャドシーエヌ）は、Tailwind ベースの美しいコンポーネント集だ」\n\n「コピー&ペーストで使えて、カスタマイズも自由自在」\n\n「CSS-in-JS（シーエスエス・イン・ジェイエス）は、JavaScript の中に CSS を書く手法」\n\n「CSS modules（CSSモジュール）は、CSS をコンポーネントごとに分離して管理する仕組みだ」',
   ARRAY['shadcn', 'css-in-js', 'css-modules'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 4, 'Sass と SCSS',
   E'「Sass（サス）と SCSS（エスシーエスエス）は、CSS を拡張した言語だ」\n\n「変数、ネスト、ミックスイン……CSS にはない便利な機能が使える」\n\n「ネスト（入れ子）で書けるから、構造がわかりやすいだろう？」\n\n「ただし、ブラウザは SCSS を直接理解できないから、CSS に変換（コンパイル）する必要があるんだ」',
   ARRAY['sass', 'scss'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 5, 'CSS 変数',
   E'「CSS variables（CSS変数）は、CSS 自体が持つ変数機能だ」\n\n「Custom properties（カスタムプロパティ）とも呼ばれる」\n\n「-- から始まる名前で定義して、var() で使用する」\n\n「テーマの切り替えにも便利だ。変数の値を変えるだけで、サイト全体の色が変わるからね」',
   ARRAY['css-variables', 'custom-properties'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 6, 'スタイルのスコープ',
   E'「スタイルの適用範囲も重要だ」\n\n「Global styles（グローバルスタイル）は、サイト全体に適用されるスタイル」\n\n「Scoped styles（スコープドスタイル）は、特定のコンポーネントだけに適用されるスタイル」\n\n「スコープを分けないと、意図しない場所にスタイルが漏れ出してしまうんだ」\n\n「だから、コンポーネントごとにスタイルを閉じ込めるのが大切さ」',
   ARRAY['global-styles', 'scoped-styles'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 7, 'リセットと正規化',
   E'「ブラウザにはデフォルトのスタイルがある。でも、ブラウザごとに微妙に違うんだ」\n\n「Reset CSS（リセットCSS）は、すべてのデフォルトスタイルをゼロにリセットする手法」\n\n「Normalize CSS（ノーマライズCSS）は、ブラウザ間の違いを揃えつつ、便利なデフォルトは残す手法」\n\n「どちらを使うかは好みだけど、何かしらの対策は必要だ」',
   ARRAY['reset-css', 'normalize-css'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[]),

  (11, 8, 'ビルドツール',
   E'「PostCSS（ポストシーエスエス）は、CSS を変換・最適化するツールだ」\n\n「プラグインを組み合わせて、様々な処理ができる」\n\n「Autoprefixer（オートプレフィクサー）は、ブラウザ対応のための接頭辞を自動で追加してくれる」\n\n「古いブラウザへの対応を自動でやってくれるから、開発者は楽ができるんだ」',
   ARRAY['postcss', 'autoprefixer'],
   ARRAY['cccccccc-cccc-cccc-cccc-cccccccccccc']::uuid[])
ON CONFLICT DO NOTHING;
