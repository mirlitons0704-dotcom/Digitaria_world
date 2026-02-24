/*
  # Re-seed story_scenes data (all chapters + images + content_en)
  
  The story_scenes table was found empty and some columns missing.
  This migration ensures columns exist and re-inserts all scene data.
*/

-- Ensure image_url column exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'story_scenes' AND column_name = 'image_url'
  ) THEN
    ALTER TABLE story_scenes ADD COLUMN image_url text;
  END IF;
END $$;

-- Ensure content_en column exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'story_scenes' AND column_name = 'content_en'
  ) THEN
    ALTER TABLE story_scenes ADD COLUMN content_en text;
  END IF;
END $$;

/*
  # Seed Story Scenes for Chapter 1

  1. New Data
    - Inserts 11 story scenes for Chapter 1 (including prologue scenes 1-3)
    - Scene 1: 目覚め (Binary)
    - Scene 2: ビットくんとの出会い (Bit)
    - Scene 3: コードバタフライとの出会い (overview)
    - Scene 4: ビットの仲間たち (Byte)
    - Scene 5: 文字の秘密 (ASCII)
    - Scene 6: 機械のことば (Machine language)
    - Scene 7: 人間の言葉に近づける (Code)
    - Scene 8: 命令の束 (Program)
    - Scene 9: 便利な道具たち (App)
    - Scene 10: ソフトとハード (Software)
    - Scene 11: データの入れ物 (File)

  2. Important Notes
    - Prologue scenes (1-3) are included under chapter_id=1 as they introduce Chapter 1
    - Each scene links to the terms introduced and characters present
    - Content is the narrative text from docs/stories/prologue.md and chapter01.md
*/

INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (1, 1, '目覚め',
   E'気がつくと、あなたは見知らぬ場所に立っていた。\n\n周りを見渡すと、すべてが「0」と「1」でできているようだ。\n空を流れる雲も、足元の地面も、遠くに見える山々も。\n\n「ここは……どこ？」\n\nすると、目の前にぽっと小さな光が現れた。',
   ARRAY['binary'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 2, 'ビットくんとの出会い',
   E'「やあ！目が覚めたんだね！」\n\n光が声を出した。よく見ると、0と1が交互に点滅している小さな存在だった。\n\n「ぼくはビット。この世界『デジタリア』のガイドだよ」\n\n「デジタリア……？」\n\n「そう！きみのいた世界では『コンピュータの中』って呼ばれている場所さ。ここではすべてが Binary——つまり0と1だけで表現されているんだ」\n\n「0と1だけで、こんなにいろんなものが？」\n\n「信じられないよね。でも本当なんだ。\nたとえば、きみの世界の『電気のスイッチ』を思い出して。\nON か OFF か、2つの状態しかないでしょ？\nコンピュータも同じ。電気が流れているか、いないか。\nそれを0と1で表しているんだよ」',
   ARRAY['bit'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 3, 'コードバタフライとの出会い',
   E'ビットくんと歩き始めると、ふわりと光が舞った。\n\n「あ……蝶？」\n\n見上げると、光り輝く蝶が何匹か飛んでいる。\nよく見ると、羽は0と1の粒子でできていて、羽ばたくたびにキラキラと輝いていた。\n\n「きれい……」\n\n「あれは『コードバタフライ』」\nビットくんが嬉しそうに言った。\n\n「この世界に住む、とても大切な存在なんだ。\nコードバタフライは、知識の記憶を運んでいるんだよ」\n\n「知識の記憶を……運ぶ？」\n\n「そう。デジタリアには、たくさんの『用語』という花が咲いているんだ。コードバタフライは、花から花へと飛び回って、意味を受粉させるように広げていく。おかげで、この世界の知識はバラバラじゃなくて、ちゃんと繋がっているんだ」\n\n一匹の蝶が、あなたの指先にそっと止まった。\n羽が触れた場所が、ほんのり温かい。\n\n「わ……」\n\n「気に入られたみたいだね」\nビットくんが微笑んだ。\n\n「そしてね、もうひとつ大切なことがある。\nきみが用語を本当に理解したとき——\nただ覚えただけじゃなくて、心から『わかった！』と思えたとき——\nその知識は光の粒になって、新しい蝶が生まれるんだ」\n\n「ぼくが学ぶと、蝶が……？」\n\n「うん。最初は小さな光の粒。\nでも学びが深まるにつれて、それは卵になり、幼虫になり、さなぎになり……\nそしていつか、こうして美しい蝶になって羽ばたく」\n\nビットくんは遠くを指さした。\n丘の向こうに、無数の光が舞っているのが見える。\n\n「あそこは『メモリーガーデン』。\n500の言葉を学び終えた人だけが行ける、特別な場所だよ」\n\n「500……」\n\n「この旅で学ぶ用語の数さ。\n全部の言葉を理解したとき、きみの蝶たちがあの丘を舞っているはずだよ」\n\n光の蝶が指先から飛び立ち、仲間と一緒に空へ消えていった。\n\nあなたは心に決めた。\nいつか、あの丘で自分の蝶たちに会いに行こう、と。',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '00000000-0000-0000-0003-000000000003']::uuid[]),

  (1, 4, 'ビットの仲間たち',
   E'歩いていると、ビットくんそっくりの存在が7人並んでいるのが見えた。\n\n「あ、みんな！紹介するね。\nぼくたちビットは、8人集まると『バイト』になるんだ」\n\n8人のビットが横一列に並ぶと、ふわっと光り輝いて、ひとつの大きな存在になった。\n\n「こんにちは。私はバイトです」\n\n穏やかな声だった。\n\n「バイトさんになると、もっとたくさんのことが表現できるようになるんだ。\nたとえば、1バイトで256種類もの違いを表せるんだよ！」\n\n「256種類……！」\n\n「そう。0から255までの数字とか、アルファベットの『A』から『Z』とか。\n8人の力を合わせると、できることがぐーんと広がるんだ」',
   ARRAY['byte'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (1, 5, '文字の秘密',
   E'バイトさんが、不思議な表を見せてくれた。\n\n「これは ASCII（アスキー）コード表といいます。\n私たち1バイトで、どの数字がどの文字を表すか決めた約束事なんです」\n\n表を見ると、「65」の横に「A」、「66」の横に「B」と書いてある。\n\n「つまり、コンピュータが『01000001』という0と1の並びを見たら、『A』という文字だとわかるってこと？」\n\n「その通りです」\n\nビットくんが嬉しそうに跳ねた。\n\n「すごいでしょ！ぼくたちの並び方で、文字になったり、数字になったり、いろんなものを表現できるんだ！」',
   ARRAY['ascii'],
   ARRAY['11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222']::uuid[]),

  (1, 6, '機械のことば',
   E'少し歩くと、奇妙な看板が立っていた。\n\n「01001000 01000101 01001100 01001100 01001111」\n\n「これ、なんて書いてあるの？」\n\nビットくんが教えてくれた。\n\n「Machine language——機械語だよ。\nコンピュータが直接理解できる唯一の言葉なんだ。\nこの看板は『HELLO』って書いてあるんだよ」\n\n「0と1だけで『HELLO』……」\n\n「昔の人間は、こうやって0と1をずらーっと並べてコンピュータに命令していたんだ。大変だったろうね……」\n\n「それは……確かに大変そう」\n\n「だから人間は、もっとわかりやすい方法を考えたんだ。それが『コード』だよ」',
   ARRAY['machine-language'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 7, '人間の言葉に近づける',
   E'次の場所には、もう少し読みやすい文字が並んでいた。\n\nprint("HELLO")\n\n「これは Code（コード）——プログラミング言語で書かれた命令文だよ」\n\n「あ、これなら少し読める気がする！」\n\n「でしょ？人間が読み書きしやすいように作られた言葉なんだ。\nこれをコンピュータが理解できる機械語に変換してくれる仕組みがあるんだよ」\n\n「通訳みたいなものかな？」\n\n「そうそう！まさに通訳！\n人間の言葉と機械語の橋渡しをしてくれるんだ」',
   ARRAY['code'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 8, '命令の束',
   E'コードが書かれた紙が何枚も積み重なっている場所に来た。\n\n「たくさんのコードが集まると、Program（プログラム）になるんだ」\n\n「プログラム……運動会のプログラムみたいなもの？」\n\n「いい例えだね！\n運動会のプログラムには『開会式→徒競走→玉入れ→……』って順番が書いてあるでしょ。\nコンピュータのプログラムも同じで、『これをやって→次にこれをやって→……』という命令の順番が書いてあるんだ」\n\n「なるほど、やることリストか！」\n\n「そう。プログラムは、コンピュータへの『やることリスト』なんだよ」',
   ARRAY['program'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 9, '便利な道具たち',
   E'街に着くと、いろいろなお店が並んでいた。\n「電卓店」「メモ帳店」「地図店」「カメラ店」……\n\n「これはみんな App（アプリ）だよ。\nApplication の略で、特定の目的のために作られたプログラムのことなんだ」\n\n「スマホに入ってるアプリと同じ？」\n\n「まさにそれ！\n電卓アプリは計算するため、カメラアプリは写真を撮るため。\nそれぞれ決まった目的があるプログラムをアプリって呼ぶんだ」',
   ARRAY['app'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 10, 'ソフトとハード',
   E'「ところで、アプリとソフトウェアって違うの？」\n\n「いい質問だね！\nSoftware（ソフトウェア）は、コンピュータ上で動くプログラム全般のことだよ。\nアプリはソフトウェアの一種なんだ」\n\nビットくんが図を描いてくれた。\n\n「きみの世界で言うと……\n『ソフトウェア』は『料理』全般、『アプリ』は『パスタ』や『カレー』みたいな具体的なメニューかな」\n\n「ソフトウェアの方が大きな概念ってこと？」\n\n「そうそう！\nそして、料理を作る『キッチン』や『フライパン』がHardware（ハードウェア）——パソコン本体とかスマホ本体のことだよ」',
   ARRAY['software'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[]),

  (1, 11, 'データの入れ物',
   E'最後に、図書館のような建物に案内された。\n棚にはたくさんの箱が並んでいる。\n\n「これは File（ファイル）だよ。\nデータを保存しておくための入れ物なんだ」\n\n「書類を入れるファイルと同じイメージ？」\n\n「ぴったり！\n文章を入れたファイル、写真を入れたファイル、音楽を入れたファイル……\n種類ごとに整理して保存しておけるんだ」\n\n箱をひとつ開けてみると、中にはきれいに整理されたデータが入っていた。\n\n「次の章では、このファイルの種類についてもっと詳しく教えるね。\nいろんな拡張子があるんだよ！」\n\n「拡張子？」\n\n「ふふ、お楽しみに！」',
   ARRAY['file'],
   ARRAY['11111111-1111-1111-1111-111111111111']::uuid[])
ON CONFLICT DO NOTHING;/*
  # Seed Story Scenes for Chapters 2-6

  Chapter 2: ファイル王国の図書館 (10 scenes, guide: ファイラ)
  Chapter 3: データ構造研究所 (10 scenes, guide: ストラクト博士)
  Chapter 4: プログラミング道場 (10 scenes, guide: ループちゃん)
  Chapter 5: Webページ建設現場 (10 scenes, guide: HTMLくん & CSSちゃん)
  Chapter 6: インターネットの海 (7 scenes, guide: ルーター船長)
*/

-- =============================================
-- Chapter 2: ファイル王国の図書館
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (2, 1, '図書館の門',
   E'ビットくんに連れられて、巨大な図書館の前に来た。\n門には「ファイル王国立図書館」と書かれている。\n\n「ここには、デジタリアのあらゆるファイルが収められているんだ」\n\n中に入ると、司書のファイラが迎えてくれた。\n\n「ようこそ、旅の方。この図書館では、ファイルを『拡張子』ごとに分類して保管しています」\n\n「拡張子って、ファイル名の最後についてるドット以降のこと？」\n\n「その通りです。拡張子を見れば、そのファイルがどんな種類のデータかわかるんですよ」',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 2, '文字だけの部屋',
   E'最初の部屋には、シンプルな書類が並んでいた。\n\n「こちらは『テキストファイル』の部屋です。\n.TXT は最もシンプルなファイル形式で、装飾のない文字だけを保存します」\n\n「メモ帳で作るファイルだ！」\n\n「はい。どんなコンピュータでも開けるのが特徴です。ただし、太字にしたり色をつけたりはできません」\n\n隣の棚を指さすと、少し変わったファイルがあった。\n\n「こちらは .MD——Markdown（マークダウン）形式です。テキストファイルなのに、簡単な記号で見出しや箇条書きを表現できるんですよ」\n\n「プログラマーに人気のある形式です」',
   ARRAY['txt', 'md'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 3, 'Webの部屋',
   E'次の部屋は、カラフルで華やかだった。\n\n「ここは『Web系ファイル』の部屋です」\n\nファイラが3つのファイルを見せてくれた。\n\n「.HTML は Web ページの『骨組み』を作るファイル。家で言えば、柱や壁の位置を決める設計図です」\n\n「.CSS は『装飾』を担当します。壁紙の色、家具の配置、カーテンの柄——見た目を美しく整えます」\n\n「そして .JS（JavaScript）は『動き』を加えます。ドアを開けたら電気がつく、ボタンを押したら音楽が流れる……そんな仕掛けを作るんです」\n\n「3つで役割分担しているんだね！」\n\n「素晴らしい理解です。そして .TS（TypeScript）は、JavaScript をより安全に書くための改良版だと思ってください」',
   ARRAY['html-file', 'css-file', 'js-file', 'ts-file'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 4, 'データの部屋',
   E'次の部屋には、整然と並んだ箱があった。\n\n「こちらは『データ形式』の部屋です。\n.JSON（ジェイソン）は、データを整理して保存する人気の形式です」\n\nファイラが中身を見せてくれた。\n\n「人間にも読めるし、コンピュータにも理解しやすい。両方に優しい形式なんです」\n\n「.CSV は、表のデータを保存する形式です。Excel で開けるので、ビジネスでよく使われます」\n\n「カンマで区切って並べるだけなので、とてもシンプルです」',
   ARRAY['json-file', 'csv-file'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 5, '画像の部屋',
   E'「ここは『画像ファイル』の部屋です」\n\n壁にはたくさんの絵が飾られていた。\n\n「.JPG（ジェイペグ）は写真向けの形式です。ファイルサイズを小さくできますが、保存するたびに少しずつ画質が落ちます」\n\n「.PNG（ピング）は、透明な部分を保存できます。ロゴやアイコンによく使われますね。画質も落ちません」\n\n「.SVG は特別です。どれだけ拡大しても、絶対にぼやけません。数学の式で図形を表現しているからです」\n\n「拡大してもぼやけないって、魔法みたい！」\n\n「アイコンやロゴには最適ですよ」',
   ARRAY['jpg-file', 'png-file', 'svg-file'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 6, '特別な書類の部屋',
   E'重厚な扉の向こうは、ビジネス書類の部屋だった。\n\n「.PDF は、どんなコンピュータで開いても同じ見た目で表示される形式です。契約書や報告書に使われます」\n\n「編集しにくいのも特徴ですね。『完成した書類』を渡すときに便利です」\n\nファイラが小さなファイルを見せてくれた。\n\n「こちらは設定ファイルたちです」\n\n「.YAML（ヤムル）は、設定を人間が読みやすく書く形式です」\n\n「.env（エンブ）は、パスワードなど秘密の情報を保存するためのファイルです。絶対に他人に見せてはいけません」\n\n「秘密のファイルがあるんだ……」',
   ARRAY['pdf-file', 'yaml-file', 'env-file'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 7, 'Reactの部屋',
   E'「こちらは少し上級者向けの部屋です」\n\nファイラが説明を続けた。\n\n「.JSX と .TSX は、React というツールで使う特別な形式です。HTML のような見た目のコードを JavaScript の中に書けるんです」\n\n「.SCSS は、CSS をもっと便利に書くための形式です。変数を使ったり、入れ子にしたり……大きなプロジェクトで重宝します」\n\n「.SQL（エスキューエル）は、データベースに命令を送るための言語です。『この条件のデータをちょうだい』とお願いするときに使います」\n\n「いろんな種類があるんだなあ……」',
   ARRAY['jsx-file', 'tsx-file', 'scss-file', 'sql-file'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 8, 'ファイルの情報',
   E'「さて、ファイルには『見えない情報』も含まれているんですよ」\n\nファイラが不思議な虫眼鏡を渡してくれた。ファイルを覗くと、隠れた文字が見えた。\n\n「これは Metadata（メタデータ）——『データについてのデータ』です」\n\n「作成日時、更新日時、ファイルサイズ、作者の名前……本で言えば、奥付のような情報ですね」\n\n「普段は見えないけど、裏側にはいろんな情報が記録されているんだ！」',
   ARRAY['metadata', 'file-metadata'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 9, '設定ファイルたち',
   E'「プロジェクトを管理するには、Config file（設定ファイル）が欠かせません」\n\n「Configuration（設定・構成）をひとつのファイルにまとめておくと、チーム全員が同じ環境で作業できます」\n\n「そして README（リードミー）——プロジェクトの説明書です。『最初にこれを読んでね』という大切なファイルなんです」\n\n「新しいプロジェクトを見るときは、まず README を読む。これが基本です」',
   ARRAY['config-file', 'configuration', 'readme'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[]),

  (2, 10, '技術の組み合わせ',
   E'図書館を出る前に、ファイラが最後の説明をしてくれた。\n\n「アプリを作るときに使う技術の組み合わせを Tech stack（技術スタック）と呼びます」\n\n「たとえば、React + TypeScript + Tailwind CSS という組み合わせは、とても人気のある技術スタックです」\n\n「データの Format（形式）を理解して、適切な技術スタックを選ぶ。これができれば、いろんなアプリが作れるようになりますよ」\n\n「ありがとう、ファイラさん！」\n\n「また来てくださいね。次は、データの『型』について学ぶ旅が待っていますよ」',
   ARRAY['tech-stack', 'format'],
   ARRAY['33333333-3333-3333-3333-333333333333']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 3: データ構造研究所
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (3, 1, '研究所への招待',
   E'図書館を出ると、白い建物が見えてきた。「データ構造研究所」という看板がかかっている。\n\n「ここでは、データをどうやって整理するか研究しているんだ」とビットくんが言った。\n\n扉を開けると、白衣を着た人物が出迎えた。\n\n「ようこそ！私はストラクト博士。データを美しく整理する方法を研究しています」\n\n「データを整理……？」\n\n「そう。データにも『型』があるんです。文字なのか、数字なのか、正しいか間違いか……型を知れば、データを正しく扱えますよ」',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 2, '基本の型たち',
   E'最初の部屋には、いくつかの棚があった。\n\n「まず、Primitive（プリミティブ）——基本データ型を紹介しましょう」\n\n「String（文字列）は、文字の並びです。"Hello" や "こんにちは" がこれですね。必ずクォーテーションで囲みます」\n\n「Number（数値）は、数字を扱います。42 や 3.14 のような数ですね。Integer は整数だけを指します」\n\n「Boolean（ブーリアン）は、true（真）か false（偽）の2つだけ。『はい』か『いいえ』の答えに使います」\n\n「シンプルだけど、これが基本なんだね」',
   ARRAY['string', 'number', 'integer', 'boolean', 'primitive', 'data-type'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 3, '「ない」の表現',
   E'「興味深いのは、『ない』という状態もデータ型で表現することです」\n\n博士が空っぽの箱を見せた。\n\n「Null（ヌル）は、『意図的に何もない』状態です。箱は用意したけど、中身を空にしておいた、というイメージですね」\n\n「Undefined（アンディファインド）は、『まだ定義されていない』状態。そもそも箱を用意し忘れた、という感じです」\n\n「どちらも『ない』だけど、意味が違うんだ……」\n\n「この違いを理解すると、エラーの原因を見つけやすくなりますよ」',
   ARRAY['null', 'undefined'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 4, 'データの入れ物',
   E'次の部屋には、箱とラベルがたくさんあった。\n\n「Variable（変数）は、データを入れておく箱です。中身は後から変えられます」\n\n「Constant（定数）は、一度入れたら変えられない箱。ずっと同じであるべき値に使います」\n\n「変わるかもしれないものは変数、絶対変わらないものは定数。使い分けが大切なんですね」',
   ARRAY['variable', 'constant'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 5, '配列という引き出し',
   E'長い棚に、番号のついた引き出しが並んでいた。\n\n「Array（配列）は、同じ種類のデータを順番に並べた構造です」\n\n「引き出しの番号を Index（インデックス）といいます。プログラミングでは0から数えるのが特徴です」\n\n「0から数えるの？」\n\n「はい、これはよくある勘違いポイントです。最初の要素は1番目ではなく、0番目なんです」',
   ARRAY['array', 'index'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 6, 'オブジェクトという整理棚',
   E'別の部屋には、ラベル付きの棚があった。\n\n「Object（オブジェクト）は、関連するデータをまとめた構造です。Key-value pair（キーと値のペア）で整理するんですよ」\n\n「名前、年齢、職業……ひとつの『人』に関する情報をまとめて管理できるんだね」\n\n「これが Record（レコード）の考え方です。ひとつひとつの項目を Field（フィールド）と呼びます」',
   ARRAY['object', 'key-value-pair', 'record', 'field'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 7, '特別なコレクション',
   E'「もっと便利なデータ構造もありますよ」\n\n博士が図を描きながら説明した。\n\n「Set（セット）は、重複のないデータの集まり。同じものを2回入れても、1個しか残りません」\n\n「Map（マップ）は、キーと値のペアを効率よく管理します。Hash（ハッシュ）とも呼ばれます」\n\n「Tuple（タプル）は、固定長の配列で、順番に意味があります。座標 (x, y) のようなものですね」\n\n「それぞれ得意なことが違うんだ……」',
   ARRAY['set', 'map', 'hash', 'tuple'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 8, '型の設計図',
   E'「大きなプロジェクトでは、データの『設計図』を作ります」\n\n博士がホワイトボードに書いた。\n\n「Schema（スキーマ）は、データ構造の設計図です。どんな項目があって、それぞれ何型か定義しておくんです」\n\n「Interface（インターフェース）は、オブジェクトの形を定義します。『この形に従ってね』という約束事です」\n\n「Type alias（型エイリアス）は、型に別名をつけること。Union type（ユニオン型）は、複数の型のどれかを許容します」',
   ARRAY['schema', 'interface', 'type-alias', 'union-type'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 9, '列挙と選択肢',
   E'「Enum（イーナム・列挙型）は、決まった選択肢だけを許す型です」\n\n「信号機の色は、赤・青・黄しかないですよね。それ以外の値が入らないよう、制限をかけることができます」\n\n「間違ったデータを防げるんだね」\n\n「その通り！型システムは、間違いを未然に防ぐ安全装置なんです」',
   ARRAY['enum'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[]),

  (3, 10, '高度なデータ構造',
   E'研究所の奥には、立体的な模型があった。\n\n「ここからは上級者向けですが、紹介しておきましょう」\n\n「Stack（スタック）は、本を積み上げるイメージ。最後に入れたものを、最初に取り出します」\n\n「Queue（キュー）は、レジの行列のイメージ。最初に並んだ人から順番に対応します」\n\n「Tree（ツリー）は、家系図のような階層構造です」\n\n「Graph（グラフ）は、駅の路線図のような、つながりの構造」\n\n「Vector（ベクトル）は、方向と大きさを持つデータ。ゲームでキャラクターを動かすときに使います」\n\n「データ構造って、こんなに種類があるんだ……！」',
   ARRAY['stack', 'queue', 'tree', 'graph', 'vector'],
   ARRAY['44444444-4444-4444-4444-444444444444']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 4: プログラミング道場
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (4, 1, '道場の門',
   E'「さあ、いよいよプログラミングの本格的な修行が始まるよ！」\n\nビットくんと一緒に、古風な道場の門をくぐった。\n\n「ようこそ、プログラミング道場へ」\n\n道着姿の女性が出迎えた。ループちゃんという名前らしい。\n\n「ここでは、コードの『作法』を学びます。正しい作法を知れば、コンピュータに正確に命令を伝えられますよ」',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 2, '文法のお稽古',
   E'「まず、Syntax（シンタックス・構文）から」\n\nループちゃんが筆で書いた。\n\n「Syntax は、プログラミング言語の文法です。人間の言葉に『てにをは』があるように、プログラムにも書き方のルールがあります」\n\n「Statement（文）は、命令の1文。Expression（式）は、値を生み出す部分です」\n\n「Operator（演算子）は、+、-、×、÷のような記号。計算や比較を行います」\n\n「= は Assignment（代入）。右側の値を、左側の変数に入れる、という意味です」',
   ARRAY['syntax', 'statement', 'expression', 'operator', 'assignment'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 3, '関数という技',
   E'「プログラミングの必殺技、Function（関数）を教えましょう」\n\n「関数は、命令をまとめて名前をつけたものです。一度作れば、何度でも呼び出せます」\n\n「Parameter（パラメータ・仮引数）は、関数を作るときに用意する『受け取り口』」\n\n「Argument（引数）は、関数を使うときに渡す『実際の値』」\n\n「Return value（戻り値）は、関数が返してくれる結果です」\n\n「Method（メソッド）は、オブジェクトに属する関数のことです」',
   ARRAY['function', 'method', 'parameter', 'argument', 'return-value', 'declaration'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 4, 'スコープの掟',
   E'「Scope（スコープ）は、変数が見える範囲のことです」\n\nループちゃんが図を描いた。\n\n「Global scope（グローバルスコープ）は、プログラム全体から見える範囲」\n\n「Local scope（ローカルスコープ）は、関数の中だけで見える範囲」\n\n「Block scope（ブロックスコープ）は、{ } の中だけで見える範囲」\n\n「Closure（クロージャ）は、関数が外側の変数を覚えている仕組み。少し難しいですが、とても便利です」',
   ARRAY['scope', 'global-scope', 'local-scope', 'block-scope', 'closure'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 5, '繰り返しの修行',
   E'「私の得意技、Loop（ループ・繰り返し）です！」\n\nループちゃんが嬉しそうに実演した。\n\n「同じことを何度も書かなくていい。これがループの力です」\n\n「Iteration（イテレーション）は、繰り返しの1回分のこと。5回ループなら、5回のイテレーションです」',
   ARRAY['loop', 'iteration'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 6, '条件分岐の術',
   E'「Conditional（条件分岐）も大切な技です」\n\n「If/else は最も基本的な条件分岐。もし〜なら、そうでなければ……」\n\n「Switch statement（switch文）は、複数の選択肢から選ぶとき便利です」\n\n「条件分岐で、プログラムは状況に応じた動きができるようになります」',
   ARRAY['conditional', 'if-else', 'switch-statement'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 7, '真と偽の世界',
   E'「条件分岐で重要なのが、Truthy と Falsy の概念です」\n\n「Truthy は、条件として『真』と見なされる値。Falsy は、『偽』と見なされる値です」\n\n「Comparison operator（比較演算子）は、===、!==、<、>などで値を比較」\n\n「Logical operator（論理演算子）は、&&（かつ）、||（または）、!（否定）」',
   ARRAY['truthy', 'falsy', 'comparison-operator', 'logical-operator'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 8, '文字列の技',
   E'「文字列を操作する技も覚えましょう」\n\n「Concatenation（連結）は、文字列をつなげること」\n\n「でも今は、Interpolation（補間）を使う方が便利です。バッククォートで囲んで、${} の中に変数を入れる」\n\n「読みやすくて、間違いも減りますね」',
   ARRAY['concatenation', 'interpolation'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 9, 'エラーと向き合う',
   E'「プログラミングにエラーはつきもの。でも、上手に付き合う方法があります」\n\n「Comment（コメント）は、コードに残すメモ。実行されないので、説明を書けます」\n\n「Debug（デバッグ）は、バグ（不具合）を見つけて直すこと」\n\n「Breakpoint（ブレークポイント）は、プログラムを途中で止める印。止めて中身を確認できます」\n\n「Exception（例外）は、予想外のエラーが起きること。Error handling（エラーハンドリング）で安全に処理します」',
   ARRAY['comment', 'debug', 'breakpoint', 'exception', 'error-handling'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[]),

  (4, 10, '良いコードの心得',
   E'「最後に、良いコードを書くための心得です」\n\nループちゃんが巻物を広げた。\n\n「Readability（可読性）——他の人が読んでもわかるコードを」\n\n「Modularity（モジュール性）——機能ごとに分けて、再利用しやすく」\n\n「Hierarchy（階層構造）——整理された構造で見通しよく」\n\n「Granularity（粒度）——関数は1つの仕事だけするように」\n\n「Line（行）ごとに Instructions（命令）を書き、Feature aware code（機能を意識したコード）を心がけましょう」\n\n「Inline coding（インラインコーディング）は避けて、きちんと関数に分けること」\n\n「これらを守れば、バグが少なく、保守しやすいコードが書けますよ」',
   ARRAY['readability', 'modularity', 'hierarchy', 'granularity', 'line', 'instructions', 'inline-coding', 'feature-aware-code'],
   ARRAY['55555555-5555-5555-5555-555555555555']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 5: Webページ建設現場
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (5, 1, '建設現場へ',
   E'道場を出ると、にぎやかな建設現場に着いた。あちこちで建物が作られている。\n\n「ここは Web ページ建設現場だよ！」\n\n双子が近づいてきた。\n\n「やあ！僕は HTML（エイチティーエムエル）」\n「私は CSS（シーエスエス）」\n\n「二人で協力して、Web ページという『家』を建てているの」\n\n「HTML が家の構造——柱や壁を担当」\n「CSS が内装——色や配置を担当」\n\n「二人セットで、初めて素敵な家になるんだ」',
   ARRAY['html', 'css'],
   ARRAY['66666666-6666-6666-6666-666666666666', '77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 2, 'HTMLの骨組み',
   E'HTML くんが設計図を見せてくれた。\n\n「HTML は Tag（タグ）を使って構造を作るんだ」\n\n「< > で囲んだものがタグ。<開始タグ>内容</終了タグ> という形だよ」\n\n「Element（要素）は、タグと中身を合わせた全体のこと」\n\n「Attribute（属性）は、タグに追加の情報を付けるもの」\n\n「DOM（Document Object Model）は、HTML をツリー構造で表したもの。JavaScript からページを操作するときに使うよ」',
   ARRAY['tag', 'element', 'attribute', 'dom'],
   ARRAY['66666666-6666-6666-6666-666666666666']::uuid[]),

  (5, 3, '名前をつける',
   E'「要素には名前をつけられるの」と CSS ちゃん。\n\n「Class（クラス）は、複数の要素に同じ名前をつけるとき」\n\n「ID は、たったひとつの要素につける固有の名前よ」\n\n「Selector（セレクタ）は、どの要素にスタイルを適用するか選ぶ方法」\n\n「Property（プロパティ）と Value（値）でスタイルを指定するの」',
   ARRAY['class', 'id', 'selector', 'property', 'value'],
   ARRAY['77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 4, 'スタイルの書き方',
   E'「Style（スタイル）の書き方は3種類あるの」\n\n「Stylesheet（スタイルシート）は、別ファイルにCSSをまとめる方法。一番おすすめよ」\n\n「Inline style（インラインスタイル）は、タグに直接書く方法。緊急のときだけにしてね」\n\n「整理されたスタイルシートが、保守しやすいサイトの秘訣よ」',
   ARRAY['style', 'stylesheet', 'inline-style'],
   ARRAY['77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 5, '箱モデル',
   E'「すべての要素は『箱』なの」\n\nCSS ちゃんが図を描いた。\n\n「Box model（ボックスモデル）を理解すれば、レイアウトがわかるわ」\n\n「Margin は要素の外側の余白」\n「Padding は要素の内側の余白」\n「Border は要素の枠線」\n\n「この3つを調整すれば、思い通りの配置ができるわ」',
   ARRAY['margin', 'padding', 'border'],
   ARRAY['77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 6, '配置の魔法',
   E'「Display（表示方法）と Position（位置）で配置を決めるんだ」とHTMLくん。\n\n「display: block は縦に積み重なる」\n「display: inline は横に並ぶ」\n「display: none は非表示」\n\n「position: relative は元の位置基準で調整」\n「position: absolute は親要素基準で自由配置」\n「position: fixed は画面に固定」\n\n「Overflow（オーバーフロー）は、はみ出した内容をどうするか。scroll にすればスクロールできるわ」',
   ARRAY['display', 'position', 'overflow'],
   ARRAY['66666666-6666-6666-6666-666666666666', '77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 7, '最新のレイアウト',
   E'「最近は Flexbox と Grid が主流よ」\n\n「Grid（グリッド）は、2方向のレイアウトが得意。複雑なページ構成に使うわ」\n\n「昔は Float（フロート）を使っていたけど、今は Grid の方が便利よ。Float を使ったら Clear で解除してね」',
   ARRAY['grid', 'float', 'clear'],
   ARRAY['77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 8, 'レスポンシブデザイン',
   E'「スマホでもパソコンでもきれいに見せたいよね」\n\n「Viewport（ビューポート）は、ブラウザの表示領域のこと」\n\n「Media query（メディアクエリ）を使うの」\n\n「Mobile-first（モバイルファースト）は、まずスマホ向けに作って、大きい画面向けに拡張する考え方」\n\n「Responsive mode（レスポンシブモード）は、ブラウザでいろんな画面サイズをシミュレーションする機能よ」',
   ARRAY['viewport', 'media-query', 'mobile-first', 'responsive-mode'],
   ARRAY['77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 9, '意味のあるHTML',
   E'「Semantic HTML（セマンティックHTML）を心がけてね」とHTMLくん。\n\n「<div> ばかり使わずに、意味のあるタグを使うんだ」\n\n「Accessibility（アクセシビリティ）——誰でも使えるサイトを目指そう」\n\n「ARIA（エリア）属性は、目の見えない人が使うスクリーンリーダーに情報を伝えるための属性よ」',
   ARRAY['semantic-html', 'aria'],
   ARRAY['66666666-6666-6666-6666-666666666666', '77777777-7777-7777-7777-777777777777']::uuid[]),

  (5, 10, '埋め込みと囲み',
   E'「他のサイトの内容を埋め込むこともできるよ」\n\n「iFrame（アイフレーム）は、別のページを枠の中に表示する方法」\n\n「Embed code（埋め込みコード）は、YouTubeやGoogleマップなどを自分のサイトに貼り付けるコード」\n\n「Container（コンテナ）と Wrapper（ラッパー）は、要素をまとめて囲む箱よ。レイアウトを整えるのに使うの」\n\n「Pseudo-class（擬似クラス）は :hover など、状態を表すセレクタ」\n\n「Pseudo-element（擬似要素）は ::before など、要素の一部を装飾するセレクタ」',
   ARRAY['iframe', 'embed-code', 'container', 'wrapper', 'pseudo-class', 'pseudo-element'],
   ARRAY['66666666-6666-6666-6666-666666666666', '77777777-7777-7777-7777-777777777777']::uuid[])
ON CONFLICT DO NOTHING;

-- =============================================
-- Chapter 6: インターネットの海
-- =============================================
INSERT INTO story_scenes (chapter_id, scene_number, title, content, terms_introduced, character_ids)
VALUES
  (6, 1, '港に到着',
   E'建設現場を抜けると、大きな港が広がっていた。\n\n「ここはインターネットの海への入り口だよ」\n\n船のそばに立つ男性が手を振った。\n\n「やあ！私はルーター船長。この海を渡って、世界中のサーバーとつながる手助けをしている」\n\n「インターネットは、世界中のコンピュータがつながった巨大なネットワークなんだ」',
   ARRAY[]::text[],
   ARRAY['11111111-1111-1111-1111-111111111111', '88888888-8888-8888-8888-888888888888']::uuid[]),

  (6, 2, '住所の仕組み',
   E'「まず、URL（ユーアールエル）を教えよう」\n\n船長が地図を広げた。\n\n「URL は Uniform Resource Locator——インターネット上の住所だ」\n\n「Domain（ドメイン）は example.com のような、覚えやすい名前」\n\n「Subdomain（サブドメイン）は www のような、ドメインの前につく部分」\n\n「実際のコンピュータは IP address（IPアドレス）という数字の住所を持っている」\n\n「DNS（ディーエヌエス）は、ドメイン名をIPアドレスに変換する電話帳のようなものだ」',
   ARRAY['url', 'subdomain', 'dns', 'ip-address'],
   ARRAY['88888888-8888-8888-8888-888888888888']::uuid[]),

  (6, 3, 'リンクの力',
   E'「Link（リンク）は、ページとページをつなぐ橋だ」\n\n「Hyperlink（ハイパーリンク）とも呼ぶ。クリックすると別のページに飛べる」\n\n「HTML では Anchor tag（アンカータグ）<a> を使って作る」\n\n「Href（エイチレフ）属性に、飛び先の URL を指定するんだ」\n\n「Path parameter（パスパラメータ）は /users/123 のように、URLのパスに含める値」\n\n「Query string（クエリ文字列）は ?name=test&age=20 のように、? 以降に追加する情報」\n\n「Query parameter（クエリパラメータ）はその中の name=test のようなひとつひとつのペアのことだ」',
   ARRAY['link', 'hyperlink', 'anchor-tag', 'href', 'path-parameter', 'query-string', 'query-parameter'],
   ARRAY['88888888-8888-8888-8888-888888888888']::uuid[]),

  (6, 4, '通信のルール',
   E'「船が港に入るとき、決まったルールがあるように、インターネットにも Protocol（プロトコル）がある」\n\n「HTTP（エイチティーティーピー）は、Webページを取得するためのルールだ」\n\n「HTTPS（エイチティーティーピーエス）は、HTTP に暗号化を加えたもの。SSL/TLS という技術で安全に通信する」\n\n「Port（ポート）は、通信の『窓口番号』のようなもの。HTTP は 80番、HTTPS は 443番を使う」\n\n「南京錠マーク 🔒 が出ていれば、HTTPS で安全に通信している証拠だ」',
   ARRAY['protocol', 'http', 'https', 'ssl-tls', 'port'],
   ARRAY['88888888-8888-8888-8888-888888888888']::uuid[]),

  (6, 5, 'リクエストとレスポンス',
   E'「通信は Request（リクエスト）と Response（レスポンス）のやり取りで成り立っている」\n\n船長が図を描いた。\n\n「ブラウザがサーバーに『お願い』を送り、サーバーが『返事』を返す。この繰り返しでWebは動いている」\n\n「Ingress（イングレス）は入ってくる通信、Egress（イーグレス）は出ていく通信のことだ」',
   ARRAY['request', 'response', 'ingress', 'egress'],
   ARRAY['88888888-8888-8888-8888-888888888888']::uuid[]),

  (6, 6, 'ステータスコード',
   E'「サーバーからの返事には Status code（ステータスコード）がつく」\n\n「200 OK は『成功！問題なし』」\n\n「400 Bad Request は『お願いの仕方が間違っている』」\n\n「401 Unauthorized は『ログインが必要です』」\n\n「403 Forbidden は『アクセス権限がありません』」\n\n「404 Not Found は『お探しのページは見つかりません』」\n\n「500 Internal Server Error は『サーバー側で問題が起きた』」\n\n「3桁の数字を見れば、何が起きたかすぐわかるんだ」',
   ARRAY['200-ok', '400-bad-request', '401-unauthorized', '403-forbidden', '404-not-found', '500-internal-server-error'],
   ARRAY['88888888-8888-8888-8888-888888888888']::uuid[]),

  (6, 7, 'その他のプロトコル',
   E'「HTTP 以外にも、目的別のプロトコルがある」\n\n「RSS（アールエスエス）は、ブログの更新情報を配信する仕組みだ。好きなサイトの新着をまとめてチェックできる」\n\n「SMTP（エスエムティーピー）は、メールを送るためのプロトコルだ」\n\n「それぞれの役割に合わせて、最適なプロトコルが使われているんだ」',
   ARRAY['rss', 'smtp'],
   ARRAY['88888888-8888-8888-8888-888888888888']::uuid[])
ON CONFLICT DO NOTHING;
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
/*
  # Add butterfly image to Chapter 1 Scene 3

  1. Changes
    - Updates the `content` column of Chapter 1, Scene 3 ("コードバタフライとの出会い")
    - Inserts an inline image marker `{{image:/code-butterfly.png}}` between the
      「きれい……」 and 「あれは『コードバタフライ』」 paragraphs
    - The marker is rendered by the StoryTeleprompter component as an inline image

  2. Notes
    - The image marker syntax `{{image:/path}}` is a convention used by the frontend
    - TTS (text-to-speech) strips these markers before generating audio
    - This does not affect any other scenes or chapters
*/

UPDATE story_scenes
SET content = E'ビットくんと歩き始めると、ふわりと光が舞った。\n\n「あ……蝶？」\n\n見上げると、光り輝く蝶が何匹か飛んでいる。\nよく見ると、羽は0と1の粒子でできていて、羽ばたくたびにキラキラと輝いていた。\n\n「きれい……」\n\n{{image:/code-butterfly.png}}\n\n「あれは『コードバタフライ』」\nビットくんが嬉しそうに言った。\n\n「この世界に住む、とても大切な存在なんだ。\nコードバタフライは、知識の記憶を運んでいるんだよ」\n\n「知識の記憶を……運ぶ？」\n\n「そう。デジタリアには、たくさんの『用語』という花が咲いているんだ。コードバタフライは、花から花へと飛び回って、意味を受粉させるように広げていく。おかげで、この世界の知識はバラバラじゃなくて、ちゃんと繋がっているんだ」\n\n一匹の蝶が、あなたの指先にそっと止まった。\n羽が触れた場所が、ほんのり温かい。\n\n「わ……」\n\n「気に入られたみたいだね」\nビットくんが微笑んだ。\n\n「そしてね、もうひとつ大切なことがある。\nきみが用語を本当に理解したとき——\nただ覚えただけじゃなくて、心から『わかった！』と思えたとき——\nその知識は光の粒になって、新しい蝶が生まれるんだ」\n\n「ぼくが学ぶと、蝶が……？」\n\n「うん。最初は小さな光の粒。\nでも学びが深まるにつれて、それは卵になり、幼虫になり、さなぎになり……\nそしていつか、こうして美しい蝶になって羽ばたく」\n\nビットくんは遠くを指さした。\n丘の向こうに、無数の光が舞っているのが見える。\n\n「あそこは『メモリーガーデン』。\n500の言葉を学び終えた人だけが行ける、特別な場所だよ」\n\n「500……」\n\n「この旅で学ぶ用語の数さ。\n全部の言葉を理解したとき、きみの蝶たちがあの丘を舞っているはずだよ」\n\n光の蝶が指先から飛び立ち、仲間と一緒に空へ消えていった。\n\nあなたは心に決めた。\nいつか、あの丘で自分の蝶たちに会いに行こう、と。'
WHERE chapter_id = 1 AND scene_number = 3;/*
  # Fix butterfly image path in Chapter 1 Scene 3

  1. Changes
    - Updates the image marker from `/code-butterfly.png` (0-byte file) to `/memorygarden.png`
    - The memorygarden.png shows ethereal glowing butterflies matching the scene description
*/

UPDATE story_scenes
SET content = replace(content, '{{image:/code-butterfly.png}}', '{{image:/memorygarden.png}}')
WHERE chapter_id = 1 AND scene_number = 3;/*
  # Use Supabase Storage URL for butterfly image

  1. Changes
    - Updates the image marker in Chapter 1 Scene 3 from local path `/memorygarden.png`
      to the Supabase Storage public URL for `code-butterfly.png`
    - The image was uploaded by the user to the `assets` bucket
*/

UPDATE story_scenes
SET content = replace(
  content,
  '{{image:/memorygarden.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.png}}'
)
WHERE chapter_id = 1 AND scene_number = 3;/*
  # Replace butterfly media with static image

  1. Changes
    - Replace `{{image:...code-butterfly.png}}` with `{{image:...butterfly1.png}}`
    - Replace `{{video:...code-butterfly.mp4}}` with `{{image:...butterfly1.png}}`
    - Both image and video markers now use the same butterfly1.png static image

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 3 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  REPLACE(
    content,
    '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.png}}',
    '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/butterfly1.png}}'
  ),
  '{{video:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.mp4}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/butterfly1.png}}'
)
WHERE chapter_id = 1 AND scene_number = 3;/*
  # Revert first butterfly image to code-butterfly.png

  1. Changes
    - First image (after "きれい……") reverted to code-butterfly.png
    - Second image (after "ほんのり温かい。") remains butterfly1.png

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 3 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  '「きれい……」' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/butterfly1.png}}',
  '「きれい……」' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/code-butterfly.png}}'
)
WHERE chapter_id = 1 AND scene_number = 3;/*
  # Add memorygarden.png image to chapter 1 scene 3

  1. Changes
    - Insert memorygarden.png image before the line "「あそこは『メモリーガーデン』。"
    - Image uses the same {{image:...}} marker format

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 3 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  '「あそこは『メモリーガーデン』。',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png}}' || E'\n\n' || '「あそこは『メモリーガーデン』。'
)
WHERE chapter_id = 1 AND scene_number = 3;/*
  # Add bits.png image to chapter 1 scene 4

  1. Changes
    - Insert bits.png image after the line "ぼくたちビットは、8人集まると『バイト』になるんだ」"
    - Image uses the {{image:...}} marker format

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 4 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  'ぼくたちビットは、8人集まると『バイト』になるんだ」',
  'ぼくたちビットは、8人集まると『バイト』になるんだ」' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png}}'
)
WHERE chapter_id = 1 AND scene_number = 4;/*
  # Add bite.png image to chapter 1 scene 4

  1. Changes
    - Insert bite.png image after "穏やかな声だった。"
    - Image uses the {{image:...}} marker format

  2. Affected Tables
    - `story_scenes` - chapter 1, scene 4 content updated
*/

UPDATE story_scenes
SET content = REPLACE(
  content,
  '穏やかな声だった。',
  '穏やかな声だった。' || E'\n\n' || '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bite.png}}'
)
WHERE chapter_id = 1 AND scene_number = 4;/*
  # Add library image to Chapter 1 Scene 11

  1. Changes
    - Update story_scenes row for chapter 1, scene 11 ("データの入れ物")
    - Set image_url to the library.png asset from Supabase Storage

  2. Notes
    - The image will appear before the text "最後に、図書館のような建物に案内された。"
*/

UPDATE story_scenes
SET image_url = 'https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/library.png'
WHERE id = '1de81af0-8f98-4e0c-84ad-2b92198790df';/*
  # Add ASCII table image to Chapter 1 Scene 5

  1. Modified Tables
    - `story_scenes`: Updated content for Chapter 1, Scene 5 ("文字の秘密")
      - Inserted ASCII.png image from Supabase storage after the line about "約束事なんです"

  2. Important Notes
    - Uses the existing {{image:URL}} marker pattern for inline images
    - Image is stored in the `assets` bucket in Supabase Storage
*/

UPDATE story_scenes
SET content = 'バイトさんが、不思議な表を見せてくれた。

「これは ASCII（アスキー）コード表といいます。
私たち1バイトで、どの数字がどの文字を表すか決めた約束事なんです」

{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png}}

表を見ると、「65」の横に「A」、「66」の横に「B」と書いてある。

「つまり、コンピュータが『01000001』という0と1の並びを見たら、『A』という文字だとわかるってこと？」

「その通りです」

ビットくんが嬉しそうに跳ねた。

「すごいでしょ！ぼくたちの並び方で、文字になったり、数字になったり、いろんなものを表現できるんだ！」'
WHERE id = '0b8f6350-d274-48ee-8bb0-07985cf1683a';/*
  # Replace print("HELLO") text with hello.png image in Chapter 1 Scene 7

  1. Modified Tables
    - `story_scenes`: Updated content for Chapter 1, Scene 7 ("人間の言葉に近づける")
      - Replaced the `print("HELLO")` text with hello.png image from Supabase Storage assets bucket

  2. Important Notes
    - Uses the existing {{image:URL}} marker pattern for inline images
    - Image is stored in the `assets` bucket in Supabase Storage
*/

UPDATE story_scenes
SET content = '次の場所には、もう少し読みやすい文字が並んでいた。

{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/hello.png}}

「これは Code（コード）——プログラミング言語で書かれた命令文だよ」

「あ、これなら少し読める気がする！」

「でしょ？人間が読み書きしやすいように作られた言葉なんだ。
これをコンピュータが理解できる機械語に変換してくれる仕組みがあるんだよ」

「通訳みたいなものかな？」

「そうそう！まさに通訳！
人間の言葉と機械語の橋渡しをしてくれるんだ」'
WHERE id = 'bd070e32-5027-45fe-b5a5-f17512a7d452';/*
  # Update CSS character to male twin

  1. Character Changes
    - `CSSちゃん` renamed to `CSSくん`
    - Role changed from タグ兄弟（妹）to タグ双子（弟）
    - Speech style changed from feminine to masculine
    - HTMLくん role updated to タグ双子（兄）

  2. Story Scene Changes
    - Scene 1 (ch5): 「私はCSS」→「僕はCSS」, feminine endings → masculine
    - Scene 3 (ch5): CSSちゃん→CSSくん, all feminine speech → masculine

  3. Notes
    - HTML and CSS are now male twins instead of brother/sister
*/

UPDATE characters
SET
  name = 'CSSくん',
  name_en = 'CSS-kun',
  role = 'タグ双子（弟）',
  personality = '美的センスがあり装飾好き',
  speech_style = '〜だよ、〜なんだ'
WHERE id = '77777777-7777-7777-7777-777777777777';

UPDATE characters
SET role = 'タグ双子（兄）'
WHERE id = '66666666-6666-6666-6666-666666666666';

UPDATE story_scenes
SET content = E'道場を出ると、にぎやかな建設現場に着いた。あちこちで建物が作られている。\n\n「ここは Web ページ建設現場だよ！」\n\n双子が近づいてきた。\n\n{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/illustrations/ch5_s1_inline2_1771822286683.png}}\n\n「やあ！僕は HTML（エイチティーエムエル）」\n「僕は CSS（シーエスエス）」\n\n「二人で協力して、Web ページという『家』を建てているんだ」\n\n「HTML が家の構造——柱や壁を担当」\n「CSS が内装——色や配置を担当」\n\n「二人セットで、初めて素敵な家になるんだ」'
WHERE id = 'd856c36c-3f0a-4c21-92bc-f098d2d57b50';

UPDATE story_scenes
SET content = E'「要素には名前をつけられるんだ」と CSS くん。\n\n「Class（クラス）は、複数の要素に同じ名前をつけるとき」\n\n「ID は、たった一つの要素につける固有の名前だよ」\n\n「Selector（セレクタ）は、どの要素にスタイルを適用するか選ぶ方法」\n\n「Property（プロパティ）と Value（値）でスタイルを指定するんだ」'
WHERE id = '9194c335-032b-488e-b1a4-42d89759ee3c';/*
  # Update Chapter 5 scenes 4 and 5 to masculine speech

  1. Story Scene Changes
    - Scene 4 (スタイルの書き方): feminine endings → masculine (の→んだ, よ→だよ, ね→な)
    - Scene 5 (箱モデル): CSSちゃん→CSSくん, feminine endings → masculine (の→んだ, わ→よ)

  2. Notes
    - Consistent with previous migration making CSS a male twin
*/

UPDATE story_scenes
SET content = E'「Style（スタイル）の書き方は3種類あるんだ」\n\n「Stylesheet（スタイルシート）は、別ファイルにCSSをまとめる方法。一番おすすめだよ」\n\n「Inline style（インラインスタイル）は、タグに直接書く方法。緊急のときだけにしてな」\n\n「整理されたスタイルシートが、保守しやすいサイトの秘訣だよ」'
WHERE id = 'eb097ad2-c1d2-484e-a478-28e614c7fba1';

UPDATE story_scenes
SET content = E'「すべての要素は『箱』なんだ」\n\nCSS くんが図を描いた。\n\n「Box model（ボックスモデル）を理解すれば、レイアウトがわかるよ」\n\n「Margin は要素の外側の余白」\n「Padding は要素の内側の余白」\n「Border は要素の枠線」\n\n「この3つを調整すれば、思い通りの配置ができるよ」'
WHERE id = 'c304bcb2-f1a6-40bb-95e7-02cbf19d8cee';/*
  # Update Chapter 5 scenes 6-10 to masculine speech

  1. Story Scene Changes
    - Scene 6 (配置の魔法): 「できるわ」→「できるよ」
    - Scene 7 (最新のレイアウト): 「主流よ」→「主流だよ」, 「使うわ」→「使うんだ」, 「便利よ」→「便利だよ」, 「してね」→「してな」
    - Scene 8 (レスポンシブデザイン): 「使うの」→「使うんだ」, 「機能よ」→「機能だよ」
    - Scene 9 (意味のあるHTML): 「してね」→「してな」, 「属性よ」→「属性なんだ」
    - Scene 10 (埋め込みと囲み): 「箱よ」→「箱だよ」, 「使うの」→「使うんだ」

  2. Notes
    - Consistent with previous migrations making CSS a male twin
*/

UPDATE story_scenes
SET content = E'「Display（表示方法）と Position（位置）で配置を決めるんだ」とHTMLくん。\n\n「display: block は縦に積み重なる」\n「display: inline は横に並ぶ」\n「display: none は非表示」\n\n「position: relative は元の位置基準で調整」\n「position: absolute は親要素基準で自由配置」\n「position: fixed は画面に固定」\n\n「Overflow（オーバーフロー）は、はみ出した内容をどうするか。scroll にすればスクロールできるよ」'
WHERE id = '1a558a74-ae85-4988-87bc-a2b5bc63dbe3';

UPDATE story_scenes
SET content = E'「最近は Flexbox と Grid が主流だよ」\n\n「Grid（グリッド）は、2方向のレイアウトが得意。複雑なページ構成に使うんだ」\n\n「昔は Float（フロート）を使っていたけど、今は Grid の方が便利だよ。Float を使ったら Clear で解除してな」'
WHERE id = '66ccc55c-43ff-42d1-93b1-70079842ae83';

UPDATE story_scenes
SET content = E'「スマホでもパソコンでもきれいに見せたいよね」\n\n「Viewport（ビューポート）は、ブラウザの表示領域のこと」\n\n「Media query（メディアクエリ）を使うんだ」\n\n「Mobile-first（モバイルファースト）は、まずスマホ向けに作って、大きい画面向けに拡張する考え方」\n\n「Responsive mode（レスポンシブモード）は、ブラウザでいろんな画面サイズをシミュレーションする機能だよ」'
WHERE id = '950c10f4-46bd-4568-ac68-5e30c1dc1e08';

UPDATE story_scenes
SET content = E'「Semantic HTML（セマンティックHTML）を心がけてな」とHTMLくん。\n\n「<div> ばかり使わずに、意味のあるタグを使うんだ」\n\n「Accessibility（アクセシビリティ）——誰でも使えるサイトを目指そう」\n\n「ARIA（エリア）属性は、目の見えない人が使うスクリーンリーダーに情報を伝えるための属性なんだ」'
WHERE id = '0b424c5e-56b5-441f-a55f-fa5c9903ef84';

UPDATE story_scenes
SET content = E'「他のサイトの内容を埋め込むこともできるよ」\n\n「iFrame（アイフレーム）は、別のページを枠の中に表示する方法」\n\n「Embed code（埋め込みコード）は、YouTubeやGoogleマップなどを自分のサイトに貼り付けるコード」\n\n「Container（コンテナ）と Wrapper（ラッパー）は、要素をまとめて囲む箱だよ。レイアウトを整えるのに使うんだ」\n\n「Pseudo-class（擬似クラス）は :hover など、状態を表すセレクタ」\n\n「Pseudo-element（擬似要素）は ::before など、要素の一部を装飾するセレクタ」'
WHERE id = 'fa738bdf-40ff-49a2-99c3-23bb0e028d85';/*
  # Update Chapter 5 Scene 6 - Improve Overflow explanation

  1. Modified Tables
    - `story_scenes`: Update content for chapter 5, scene 6
  2. Changes
    - Replace terse Overflow explanation with a clearer, more concrete description
    - Add mention of `hidden` value alongside `scroll` for better understanding
    - Maintain the existing male speech style (だよ / んだ)
*/

UPDATE story_scenes
SET content = '「Display（表示方法）と Position（位置）で配置を決めるんだ」とHTMLくん。

「display: block は縦に積み重なる」
「display: inline は横に並ぶ」
「display: none は非表示」

「position: relative は元の位置基準で調整」
「position: absolute は親要素基準で自由配置」
「position: fixed は画面に固定」

「Overflow（オーバーフロー）は、箱に入りきらない内容をどう扱うかを決めるプロパティだよ。hidden にすれば、はみ出た部分を隠す。scroll にすれば、スクロールして見られるようになるんだ」'
WHERE id = '1a558a74-ae85-4988-87bc-a2b5bc63dbe3';/*
  # Add size hints to existing inline image markers

  Updates existing {{image:url}} markers that need non-default sizes:
  - bits.png → |size=full (diagram showing 8 bits)
  - memorygarden.png → |size=lg (landscape illustration)
  - ASCII.png → |size=lg (reference table)

  All other existing markers remain unchanged and render at the default 'md' size.
*/

-- bits.png → full width
UPDATE story_scenes
SET content = REPLACE(
  content,
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png|size=full}}'
)
WHERE content LIKE '%{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/bits.png}}%';

-- memorygarden.png → lg
UPDATE story_scenes
SET content = REPLACE(
  content,
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png|size=lg}}'
)
WHERE content LIKE '%{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/memorygarden.png}}%';

-- ASCII.png → lg
UPDATE story_scenes
SET content = REPLACE(
  content,
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png}}',
  '{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png|size=lg}}'
)
WHERE content LIKE '%{{image:https://erkvissuydjosstfhywf.supabase.co/storage/v1/object/public/assets/ASCII.png}}%';
/*
  # Seed English story translations for all scenes (Chapters 1–17)

  Updates every row in story_scenes with an English translation in
  the new `content_en` column.  Rows are identified by
  (chapter_id, scene_number) so no hard-coded UUIDs are needed.
*/

-- =============================================
-- Chapter 1  (11 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'You opened your eyes and found yourself standing in an unknown place.\n\nLooking around, everything seemed to be made of "0"s and "1"s.\nThe clouds drifting across the sky, the ground beneath your feet, the mountains in the distance.\n\n"Where… am I?"\n\nThen, a tiny light appeared right in front of you.'
WHERE chapter_id = 1 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Hey! You''re awake!"\n\nThe light spoke. Looking closely, it was a small being flickering between 0 and 1.\n\n"I''m Bit. I''m a guide for this world called ''Digitaria''"\n\n"Digitaria…?"\n\n"That''s right! In your world, it''s called ''inside a computer.'' Here, everything is expressed in Binary—just 0s and 1s"\n\n"All of this, with just 0s and 1s?"\n\n"Hard to believe, right? But it''s true.\nThink of a light switch in your world.\nIt can only be ON or OFF—just two states, right?\nComputers work the same way. Either electricity is flowing, or it isn''t.\nWe represent that as 0 and 1"'
WHERE chapter_id = 1 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'As you began walking with Bit, a soft light danced through the air.\n\n"Oh… a butterfly?"\n\nLooking up, you saw several glowing butterflies flying above.\nTheir wings were made of particles of 0s and 1s, sparkling with every beat.\n\n"They''re beautiful…"\n\n"Those are ''Code Butterflies''"\nBit said happily.\n\n"They''re very important beings in this world.\nCode Butterflies carry the memories of knowledge"\n\n"They carry… the memories of knowledge?"\n\n"Yes. In Digitaria, there are many ''term flowers'' blooming. Code Butterflies fly from flower to flower, spreading meaning like pollination. That''s why the knowledge in this world isn''t scattered—it''s all connected"\n\nA butterfly gently landed on your fingertip.\nWhere its wings touched, you felt a faint warmth.\n\n"Wow…"\n\n"It seems to like you"\nBit smiled.\n\n"And there''s one more important thing.\nWhen you truly understand a term—\nnot just memorize it, but really feel ''I get it!''—\nthat knowledge becomes a particle of light, and a new butterfly is born"\n\n"When I learn, a butterfly…?"\n\n"Yes. At first, it''s just a tiny particle of light.\nBut as your understanding deepens, it becomes an egg, then a larva, then a chrysalis…\nand someday, it spreads its wings and flies like these beautiful butterflies"\n\nBit pointed into the distance.\nBeyond the hill, you could see countless lights dancing.\n\n"That''s the ''Memory Garden.''\nOnly those who have learned all 500 words can go there—it''s a special place"\n\n"500…"\n\n"That''s the number of terms you''ll learn on this journey.\nWhen you''ve understood every word, your butterflies will be dancing on that hill"\n\nThe glowing butterfly took off from your fingertip and disappeared into the sky with its companions.\n\nYou made up your mind.\nSomeday, you would visit that hill to see your own butterflies.'
WHERE chapter_id = 1 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'While walking, you spotted seven beings that looked just like Bit lined up in a row.\n\n"Oh, everyone! Let me introduce you.\nWhen eight of us Bits gather together, we become a ''Byte''"\n\nThe eight Bits lined up side by side, and with a flash of light, they merged into one larger being.\n\n"Hello. I am Byte"\n\nThe voice was gentle and calm.\n\n"When we become Byte, we can express so much more.\nFor example, one Byte can represent 256 different things!"\n\n"256 things…!"\n\n"That''s right. Numbers from 0 to 255, letters from ''A'' to ''Z''…\nWhen eight of us combine our power, what we can do expands enormously"'
WHERE chapter_id = 1 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'Byte showed you a mysterious chart.\n\n"This is called the ASCII code table.\nIt''s an agreement about which number represents which character, using one Byte"\n\nLooking at the chart, "65" was next to "A" and "66" was next to "B."\n\n"So when a computer sees the sequence ''01000001'' in 0s and 1s, it knows it means the letter ''A''?"\n\n"Exactly"\n\nBit bounced happily.\n\n"Isn''t it amazing! Depending on how we''re arranged, we can represent letters, numbers, and all sorts of things!"'
WHERE chapter_id = 1 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'After walking a bit more, you came across a strange signpost.\n\n"01001000 01000101 01001100 01001100 01001111"\n\n"What does this say?"\n\nBit explained:\n\n"That''s Machine language.\nIt''s the only language a computer can directly understand.\nThis sign says ''HELLO''"\n\n"''HELLO'' in just 0s and 1s…"\n\n"Long ago, humans would line up 0s and 1s like this to give instructions to computers. It must have been quite a challenge…"\n\n"That does sound really hard…"\n\n"That''s why humans came up with an easier way. That''s what ''Code'' is"'
WHERE chapter_id = 1 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'At the next spot, there were slightly more readable characters.\n\nprint("HELLO")\n\n"This is Code—an instruction written in a programming language"\n\n"Oh, I can almost read this one!"\n\n"Right? It''s a language made to be easy for humans to read and write.\nThere''s a mechanism that converts this into machine language that computers can understand"\n\n"Like a translator?"\n\n"Exactly! Just like a translator!\nIt bridges the gap between human language and machine language"'
WHERE chapter_id = 1 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'You arrived at a place where many sheets of paper with code were stacked up.\n\n"When lots of code comes together, it becomes a Program"\n\n"A program… like a sports day program?"\n\n"Great analogy!\nA sports day program lists things in order: ''opening ceremony → sprint race → ball toss → …''\nA computer program is the same—it''s a list of instructions in order: ''do this → then do this → …''"\n\n"So it''s like a to-do list!"\n\n"That''s right. A program is a ''to-do list'' for the computer"'
WHERE chapter_id = 1 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'Arriving in town, you saw various shops lined up.\n"Calculator Shop" "Notepad Shop" "Map Shop" "Camera Shop"…\n\n"These are all Apps.\nShort for Application—programs made for a specific purpose"\n\n"Like the apps on a smartphone?"\n\n"Exactly!\nA calculator app is for calculating, a camera app is for taking photos.\nPrograms with specific purposes are called apps"'
WHERE chapter_id = 1 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"By the way, are apps and software different?"\n\n"Great question!\nSoftware refers to all programs that run on a computer.\nApps are one type of software"\n\nBit drew a diagram.\n\n"In your world…\n''Software'' is like ''cooking'' in general, and ''apps'' are specific dishes like ''pasta'' or ''curry''"\n\n"So software is the bigger concept?"\n\n"Exactly!\nAnd the ''kitchen'' and ''frying pan'' used to cook are Hardware—the physical computer or smartphone itself"'
WHERE chapter_id = 1 AND scene_number = 10;

UPDATE story_scenes SET content_en = E'Finally, you were led to a library-like building.\nThe shelves were lined with many boxes.\n\n"These are Files.\nContainers for storing data"\n\n"Like a file folder for documents?"\n\n"Perfect analogy!\nFiles for text, files for photos, files for music…\nYou can organize and save data by type"\n\nYou opened one box and found neatly organized data inside.\n\n"In the next chapter, I''ll teach you more about the different types of files.\nThere are all kinds of extensions!"\n\n"Extensions?"\n\n"Hehe, look forward to it!"'
WHERE chapter_id = 1 AND scene_number = 11;

-- =============================================
-- Chapter 2  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Bit led you to a massive library. The gate read "File Kingdom Royal Library."\n\n"This library holds every kind of file in Digitaria"\n\nInside, the librarian Fila greeted you.\n\n"Welcome, traveler. In this library, we classify and store files by their ''extensions''"\n\n"Extensions—the part after the dot at the end of a file name?"\n\n"Exactly. By looking at the extension, you can tell what kind of data the file contains"'
WHERE chapter_id = 2 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'The first room had simple documents lined up.\n\n"This is the ''Text File'' room.\n.TXT is the simplest file format, storing only plain text without any formatting"\n\n"Like files made with Notepad!"\n\n"Yes. The great thing is that any computer can open them. However, you can''t make text bold or add colors"\n\nShe pointed to the next shelf, where some unusual files sat.\n\n"These are .MD—Markdown format. They''re text files, but you can use simple symbols to create headings and bullet points"\n\n"It''s a very popular format among programmers"'
WHERE chapter_id = 2 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'The next room was colorful and lively.\n\n"This is the ''Web Files'' room"\n\nFila showed three files.\n\n"An .HTML file creates the ''skeleton'' of a web page. Think of it as the blueprint that determines where the walls and pillars go in a house"\n\n".CSS handles the ''decoration.'' Wallpaper colors, furniture placement, curtain patterns—it makes everything look beautiful"\n\n"And .JS (JavaScript) adds ''movement.'' Open a door and the lights turn on, press a button and music plays—it creates those kinds of mechanisms"\n\n"So the three of them share the work!"\n\n"Wonderful understanding. And .TS (TypeScript) is an improved version of JavaScript that lets you write code more safely"'
WHERE chapter_id = 2 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The next room had neatly arranged boxes.\n\n"This is the ''Data Formats'' room.\n.JSON is a popular format for organizing and storing data"\n\nFila showed the contents.\n\n"It''s readable by humans and easy for computers to understand. A format that''s friendly to both"\n\n".CSV is a format for storing tabular data. It''s commonly used in business since it can be opened in Excel"\n\n"It''s very simple—just values separated by commas"'
WHERE chapter_id = 2 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"This is the ''Image Files'' room"\n\nThe walls were decorated with many pictures.\n\n".JPG (JPEG) is a format for photographs. It can make file sizes small, but the quality degrades slightly each time you save"\n\n".PNG can preserve transparent areas. It''s often used for logos and icons, and the quality doesn''t degrade"\n\n".SVG is special. No matter how much you zoom in, it never gets blurry. That''s because it represents shapes using mathematical formulas"\n\n"It never gets blurry when you zoom in? That''s like magic!"\n\n"It''s perfect for icons and logos"'
WHERE chapter_id = 2 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'Beyond a heavy door was a room of business documents.\n\n".PDF is a format that looks the same on any computer. It''s used for contracts and reports"\n\n"It''s also hard to edit, which is actually a feature. It''s convenient when you want to share ''finished documents''"\n\nFila showed some small files.\n\n"These are configuration files"\n\n".YAML is a format for writing settings in a human-readable way"\n\n".env is a file for storing secret information like passwords. You must never show it to anyone"\n\n"There are secret files too…"'
WHERE chapter_id = 2 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"This room is for more advanced users"\n\nFila continued.\n\n".JSX and .TSX are special formats used with a tool called React. You can write HTML-like code inside JavaScript"\n\n".SCSS is a format for writing CSS more conveniently. You can use variables, nest styles… it''s very useful for large projects"\n\n".SQL is a language for sending commands to a database. You use it when you want to ask ''give me data matching these conditions''"\n\n"There are so many different types…"'
WHERE chapter_id = 2 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Files also contain ''invisible information,'' you know"\n\nFila handed you a mysterious magnifying glass. Looking through it at a file, you could see hidden text.\n\n"This is Metadata—''data about data''"\n\n"Creation date, modification date, file size, author''s name… Think of it like the colophon in a book"\n\n"So there''s all sorts of information recorded behind the scenes that you normally can''t see!"'
WHERE chapter_id = 2 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"To manage a project, Config files are essential"\n\n"Configuration is gathered into a single file so that everyone on the team can work in the same environment"\n\n"And README—the project''s instruction manual. It''s a very important file that says ''please read this first''"\n\n"When looking at a new project, always read the README first. That''s the basic rule"'
WHERE chapter_id = 2 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'Before leaving the library, Fila gave one final explanation.\n\n"The combination of technologies used to build an app is called a Tech stack"\n\n"For example, React + TypeScript + Tailwind CSS is a very popular tech stack"\n\n"Once you understand data Formats and choose the right tech stack, you''ll be able to build all kinds of apps"\n\n"Thank you, Fila!"\n\n"Come back anytime. Next, a journey awaits where you''ll learn about data ''types''"'
WHERE chapter_id = 2 AND scene_number = 10;

-- =============================================
-- Chapter 3  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'After leaving the library, a white building came into view. A sign read "Data Structure Research Institute."\n\n"This is where they research how to organize data," said Bit.\n\nOpening the door, a person in a lab coat greeted you.\n\n"Welcome! I''m Dr. Struct. I research beautiful ways to organize data"\n\n"Organize data…?"\n\n"Yes. Data has ''types.'' Is it text? A number? True or false? If you know the type, you can handle data correctly"'
WHERE chapter_id = 3 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'The first room had several shelves.\n\n"First, let me introduce Primitive—the basic data types"\n\n"String is a sequence of characters. Things like \\"Hello\\" or \\"こんにちは.\\" Always enclosed in quotation marks"\n\n"Number handles numerical values. Numbers like 42 or 3.14. Integer refers specifically to whole numbers"\n\n"Boolean has only two values: true or false. It''s used for ''yes'' or ''no'' answers"\n\n"Simple, but these are the fundamentals"'
WHERE chapter_id = 3 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"What''s fascinating is that ''nothing'' can also be expressed as a data type"\n\nThe doctor showed an empty box.\n\n"Null means ''intentionally nothing.'' The box is prepared, but you deliberately left it empty"\n\n"Undefined means ''not yet defined.'' You forgot to prepare the box in the first place"\n\n"Both mean ''nothing,'' but they have different meanings…"\n\n"Understanding this difference makes it much easier to find the cause of errors"'
WHERE chapter_id = 3 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The next room was full of boxes and labels.\n\n"A Variable is a box for storing data. You can change its contents later"\n\n"A Constant is a box that, once filled, cannot be changed. It''s used for values that should always stay the same"\n\n"Use a variable for things that might change, and a constant for things that never should. Knowing when to use which is important"'
WHERE chapter_id = 3 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'A long shelf had numbered drawers lined up.\n\n"An Array is a structure where data of the same kind is arranged in order"\n\n"The drawer number is called an Index. In programming, we start counting from 0"\n\n"Counting from 0?"\n\n"Yes, this is a common point of confusion. The first element is not number 1—it''s number 0"'
WHERE chapter_id = 3 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'Another room had labeled shelves.\n\n"An Object is a structure that groups related data together. It''s organized using Key-value pairs"\n\n"Name, age, occupation… You can manage all the information about one ''person'' together"\n\n"This is the concept of a Record. Each individual item is called a Field"'
WHERE chapter_id = 3 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are even more useful data structures"\n\nThe doctor explained while drawing diagrams.\n\n"A Set is a collection with no duplicates. Even if you add the same thing twice, only one remains"\n\n"A Map efficiently manages key-value pairs. It''s also called a Hash"\n\n"A Tuple is a fixed-length array where the order matters. Like coordinates (x, y)"\n\n"Each one has different strengths…"'
WHERE chapter_id = 3 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"For large projects, we create ''blueprints'' for data"\n\nThe doctor wrote on a whiteboard.\n\n"A Schema is a blueprint for data structure. It defines what fields exist and what type each one is"\n\n"An Interface defines the shape of an object. It''s a contract that says ''follow this shape''"\n\n"A Type alias gives another name to a type. A Union type allows multiple possible types"'
WHERE chapter_id = 3 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"An Enum (enumeration type) is a type that only allows a fixed set of choices"\n\n"Traffic lights can only be red, green, or yellow, right? You can restrict values so nothing else can be entered"\n\n"So it prevents wrong data"\n\n"Exactly! A type system is a safety mechanism that prevents mistakes before they happen"'
WHERE chapter_id = 3 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'Deep inside the institute, there were three-dimensional models.\n\n"These are more advanced, but let me introduce them"\n\n"A Stack is like stacking books. You take out the last thing you put in first"\n\n"A Queue is like a line at a cashier. The first person in line is served first"\n\n"A Tree is a hierarchical structure, like a family tree"\n\n"A Graph is a connection structure, like a train route map"\n\n"A Vector is data with direction and magnitude. It''s used in games to move characters"\n\n"There are so many kinds of data structures…!"'
WHERE chapter_id = 3 AND scene_number = 10;

-- =============================================
-- Chapter 4  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'"Now, it''s time for real programming training!"\n\nYou passed through the gate of an old-fashioned dojo with Bit.\n\n"Welcome to the Programming Dojo"\n\nA woman in training clothes greeted you. Her name was Loop.\n\n"Here, you will learn the ''etiquette'' of code. With proper etiquette, you can give precise instructions to computers"'
WHERE chapter_id = 4 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"First, let''s start with Syntax"\n\nLoop wrote with a brush.\n\n"Syntax is the grammar of a programming language. Just as human language has grammar rules, programs have rules for how to write them"\n\n"A Statement is a single instruction. An Expression is a part that produces a value"\n\n"An Operator is a symbol like +, -, ×, ÷. It performs calculations or comparisons"\n\n"= is Assignment. It means ''put the value on the right into the variable on the left''"'
WHERE chapter_id = 4 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Let me teach you programming''s special move: the Function"\n\n"A function bundles instructions and gives them a name. Once created, you can call it as many times as you like"\n\n"A Parameter is the ''receiving slot'' you set up when creating a function"\n\n"An Argument is the ''actual value'' you pass when using a function"\n\n"A Return value is the result a function gives back"\n\n"A Method is a function that belongs to an object"'
WHERE chapter_id = 4 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Scope is the range where a variable is visible"\n\nLoop drew a diagram.\n\n"Global scope is the range visible from the entire program"\n\n"Local scope is the range visible only inside a function"\n\n"Block scope is the range visible only inside { }"\n\n"Closure is a mechanism where a function remembers variables from its outer scope. It''s a bit tricky, but very useful"'
WHERE chapter_id = 4 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Here''s my specialty: the Loop!"\n\nLoop demonstrated enthusiastically.\n\n"You don''t have to write the same thing over and over. That''s the power of loops"\n\n"An Iteration is one pass through a loop. If you loop 5 times, that''s 5 iterations"'
WHERE chapter_id = 4 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Conditionals are also an important technique"\n\n"If/else is the most basic conditional. ''If this, then do this; otherwise, do that…''"\n\n"A Switch statement is convenient when choosing from multiple options"\n\n"With conditionals, a program can behave differently depending on the situation"'
WHERE chapter_id = 4 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"For conditionals, the concepts of Truthy and Falsy are important"\n\n"Truthy values are treated as ''true'' in conditions. Falsy values are treated as ''false''"\n\n"Comparison operators like ===, !==, <, > compare values"\n\n"Logical operators: && (and), || (or), ! (not)"'
WHERE chapter_id = 4 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Let''s also learn string manipulation techniques"\n\n"Concatenation means joining strings together"\n\n"But nowadays, Interpolation is more convenient. Wrap text in backticks and put variables inside ${}"\n\n"It''s easier to read and reduces mistakes"'
WHERE chapter_id = 4 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Errors are a natural part of programming. But there are ways to deal with them"\n\n"A Comment is a note you leave in your code. It doesn''t get executed, so you can write explanations"\n\n"Debug means finding and fixing bugs (defects)"\n\n"A Breakpoint is a marker that pauses the program. You can stop it and examine what''s inside"\n\n"An Exception is when an unexpected error occurs. Error handling lets you deal with it safely"'
WHERE chapter_id = 4 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"Finally, here are the principles of writing good code"\n\nLoop unrolled a scroll.\n\n"Readability—write code that others can understand too"\n\n"Modularity—divide by function so it''s easy to reuse"\n\n"Hierarchy—keep things organized with clear structure"\n\n"Granularity—each function should do only one job"\n\n"Write Instructions line by line and practice Feature-aware code"\n\n"Avoid Inline coding—properly separate logic into functions"\n\n"Follow these principles and you''ll write code with fewer bugs that''s easier to maintain"'
WHERE chapter_id = 4 AND scene_number = 10;

-- =============================================
-- Chapter 5  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the dojo, you arrived at a bustling construction site. Buildings were being constructed everywhere.\n\n"This is the Web Page Construction Site!"\n\nA pair of twins approached.\n\n"Hi! I''m HTML"\n"And I''m CSS"\n\n"Together, we build ''houses'' called web pages"\n\n"HTML handles the structure—the pillars and walls"\n"CSS handles the interior—the colors and layout"\n\n"The two of us together is what makes a great house"'
WHERE chapter_id = 5 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'HTML showed you a blueprint.\n\n"HTML uses Tags to create structure"\n\n"Things wrapped in < > are tags. They follow the pattern <opening tag>content</closing tag>"\n\n"An Element is the whole thing—tag plus its contents"\n\n"An Attribute adds extra information to a tag"\n\n"The DOM (Document Object Model) represents HTML as a tree structure. It''s used when JavaScript manipulates the page"'
WHERE chapter_id = 5 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"You can give names to elements," said CSS.\n\n"A Class is for giving the same name to multiple elements"\n\n"An ID is a unique name given to just one element"\n\n"A Selector is how you choose which elements to apply styles to"\n\n"You specify styles with a Property and a Value"'
WHERE chapter_id = 5 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"There are three ways to write Styles"\n\n"A Stylesheet is putting CSS in a separate file. That''s the most recommended way"\n\n"Inline style is writing it directly on the tag. Only use it in emergencies"\n\n"Well-organized stylesheets are the key to a maintainable site"'
WHERE chapter_id = 5 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Every element is a ''box''"\n\nCSS drew a diagram.\n\n"If you understand the Box model, you''ll understand layout"\n\n"Margin is the space outside the element"\n"Padding is the space inside the element"\n"Border is the element''s frame"\n\n"Adjust these three and you can achieve any layout you want"'
WHERE chapter_id = 5 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Display and Position determine how things are placed," said HTML.\n\n"display: block stacks elements vertically"\n"display: inline arranges them horizontally"\n"display: none hides them"\n\n"position: relative adjusts from the original position"\n"position: absolute places freely based on the parent"\n"position: fixed keeps it fixed on the screen"\n\n"Overflow is a property that controls what happens when content doesn''t fit in its box. Use hidden to clip the overflow, or scroll to make it scrollable"'
WHERE chapter_id = 5 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Nowadays, Flexbox and Grid are the mainstream"\n\n"Grid is great for two-dimensional layouts. It''s used for complex page compositions"\n\n"Float used to be common, but Grid is more convenient now. If you do use Float, don''t forget to Clear it"'
WHERE chapter_id = 5 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"You want it to look good on both phones and desktops, right?"\n\n"Viewport is the visible area of the browser"\n\n"You use Media queries for that"\n\n"Mobile-first means designing for phones first, then expanding for larger screens"\n\n"Responsive mode is a browser feature that simulates different screen sizes"'
WHERE chapter_id = 5 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Practice Semantic HTML," said HTML.\n\n"Instead of using <div> for everything, use tags that convey meaning"\n\n"Accessibility—aim for a site everyone can use"\n\n"ARIA attributes convey information to screen readers used by visually impaired people"'
WHERE chapter_id = 5 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"You can also embed content from other sites"\n\n"An iFrame displays another page inside a frame"\n\n"Embed code is code for pasting things like YouTube videos or Google Maps into your site"\n\n"Container and Wrapper are boxes that group elements together. They''re used to organize layout"\n\n"A Pseudo-class like :hover represents a state"\n\n"A Pseudo-element like ::before decorates part of an element"'
WHERE chapter_id = 5 AND scene_number = 10;

-- =============================================
-- Chapter 6  (7 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Past the construction site, a large port spread before you.\n\n"This is the gateway to the Internet Sea"\n\nA man standing by a ship waved.\n\n"Hey there! I''m Captain Router. I help ships cross this sea and connect to servers all around the world"\n\n"The Internet is a vast network connecting computers all over the world"'
WHERE chapter_id = 6 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"First, let me teach you about URLs"\n\nThe captain spread out a map.\n\n"A URL is a Uniform Resource Locator—an address on the Internet"\n\n"A Domain is an easy-to-remember name like example.com"\n\n"A Subdomain is the part before the domain, like www"\n\n"The actual computers have numerical addresses called IP addresses"\n\n"DNS is like a phone book that converts domain names into IP addresses"'
WHERE chapter_id = 6 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Link is a bridge connecting page to page"\n\n"Also called a Hyperlink. Click it and you jump to another page"\n\n"In HTML, you create them using the Anchor tag <a>"\n\n"The Href attribute specifies the destination URL"\n\n"A Path parameter is a value in the URL path, like /users/123"\n\n"A Query string is information added after ?, like ?name=test&age=20"\n\n"A Query parameter is each individual pair like name=test within the query string"'
WHERE chapter_id = 6 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Just as ships follow rules when entering port, the Internet has Protocols"\n\n"HTTP is the protocol for fetching web pages"\n\n"HTTPS adds encryption to HTTP. It uses SSL/TLS technology for secure communication"\n\n"A Port is like a ''window number'' for communication. HTTP uses port 80, HTTPS uses port 443"\n\n"If you see the padlock icon 🔒, that means the site is communicating securely via HTTPS"'
WHERE chapter_id = 6 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Communication works through an exchange of Requests and Responses"\n\nThe captain drew a diagram.\n\n"The browser sends a ''request'' to the server, and the server sends back a ''response.'' The web runs on this back-and-forth"\n\n"Ingress is incoming traffic, and Egress is outgoing traffic"'
WHERE chapter_id = 6 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Server responses come with a Status code"\n\n"200 OK means ''Success! No problems''"\n\n"400 Bad Request means ''Your request was incorrect''"\n\n"401 Unauthorized means ''You need to log in''"\n\n"403 Forbidden means ''You don''t have permission''"\n\n"404 Not Found means ''The page you''re looking for doesn''t exist''"\n\n"500 Internal Server Error means ''Something went wrong on the server''"\n\n"These three-digit numbers instantly tell you what happened"'
WHERE chapter_id = 6 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are protocols for purposes other than HTTP too"\n\n"RSS is a system for distributing blog updates. You can check the latest posts from your favorite sites all in one place"\n\n"SMTP is the protocol for sending email"\n\n"Each protocol is used according to its specific role"'
WHERE chapter_id = 6 AND scene_number = 7;

-- =============================================
-- Chapter 7  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the port, you reached a dojo on top of a mountain. A gate read "JavaScript Dojo."\n\n"This is where you''ll learn to bring movement to the Web," said Bit.\n\nA white-haired master greeted you.\n\n"Welcome. I am JS Master. I shall teach you the secrets of JavaScript"\n\n"JavaScript is a language that breathes life into web pages. It makes things happen when you click a button"\n\n"TypeScript is an improved version of JavaScript that adds ''types.'' It lets you write code more safely"'
WHERE chapter_id = 7 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"ES6 was a major update to JavaScript that came out in 2015"\n\n"ECMAScript is the official name for JavaScript. ES6 is technically ECMAScript 2015"\n\n"Let and Const are ways to declare variables"\n\n"An Arrow function is a new, shorter way to write functions"\n\n"The => symbol looks like an arrow, doesn''t it?"'
WHERE chapter_id = 7 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"On the Web, there''s a lot of ''waiting.'' You can''t have things freeze while fetching data"\n\n"A Promise is a mechanism that ''promises a future result''"\n\n"Async/Await makes Promises easier to read"\n\n"Fetch is the technique for retrieving data from a server"\n\n"Then/catch is the traditional way of handling Promises"'
WHERE chapter_id = 7 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Let me teach you some handy syntax added in ES6"\n\n"The Spread operator expands arrays and objects"\n\n"Destructuring extracts values from arrays and objects"\n\n"Master these and your code will become much shorter"'
WHERE chapter_id = 7 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Large programs are divided into Modules"\n\n"Import brings things in from other files"\n"Export makes things available to other files"\n\n"Default export publishes one main thing from a file"\n\n"Named export publishes multiple features with names"\n\n"Barrel exports re-export multiple modules from one place"\n\n"Library import lets you use convenient external libraries"'
WHERE chapter_id = 7 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"An Event is a notification that something happened"\n\n"Clicks, key presses, scrolling… every user action becomes an event"\n\n"An Event listener is a watchman that monitors events"\n\n"An Event handler is the code that runs when an event occurs"\n\n"Prevent default stops the browser''s built-in behavior"\n\n"The This keyword refers to the current object. It changes depending on context, so be careful"'
WHERE chapter_id = 7 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are also techniques for controlling time"\n\n"setTimeout runs something once after a specified delay"\n\n"setInterval runs something repeatedly at a specified interval"\n\n"You can make clocks tick on web pages or fetch data periodically"'
WHERE chapter_id = 7 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Let me teach you powerful array manipulation techniques"\n\n"Map function transforms every element and creates a new array"\n\n"Filter function extracts only elements that match a condition"\n\n"Reduce function combines all elements into a single value"\n\n"ForEach runs a process on every element"\n"Find returns the first element matching a condition"\n\n"Combine these and you can write complex data processing concisely"'
WHERE chapter_id = 7 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Console log is the absolute basics of debugging"\n\n"Get retrieves a value, Typeof checks the type"\n\n"Parsing means analyzing a string and converting it into data"\n\n"Zod is a library for validating data shapes in TypeScript"\n\n"A Utility is a handy helper function"'
WHERE chapter_id = 7 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"JavaScript can run not just in browsers, but also on servers"\n\n"Node.js is an environment for running JavaScript on servers"\n\n"Thanks to this, you can write both frontend and backend in JavaScript"\n\n"In the next chapter, you''ll learn React. You''ll be able to build more complex UIs using your JavaScript knowledge"\n\n"Thank you, Master!"'
WHERE chapter_id = 7 AND scene_number = 10;

-- =============================================
-- Chapter 8  (9 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Coming down the mountain, you saw a modern school building.\n\n"Welcome to Component Academy!"\n\nA young woman teacher greeted you.\n\n"I''m React Sensei. I teach React—a UI construction library"\n\n"React was created by Facebook and is very popular. Its specialty is building UIs by dividing them into ''parts''"\n\n"A React component is one of those ''parts.'' You combine small parts to build a large screen"'
WHERE chapter_id = 8 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Functional components are the current standard"\n\n"JSX is a syntax that lets you write HTML-like code inside JavaScript"\n\n"TSX is the TypeScript version of JSX"\n\n"It looks like HTML, but it''s actually JavaScript"\n\n"Use className instead of class—that''s a JSX rule"'
WHERE chapter_id = 8 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Props are the way to pass data from parent to child"\n\n"Children prop is a special Prop that passes the content between tags"\n\n"State is changeable data that a component owns"\n\n"Local state is data only for that component, and Global state is data shared across the entire app"'
WHERE chapter_id = 8 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"A Hook is magic that adds features to functional components"\n\n"useState is the Hook for using State"\n\n"useEffect handles Side effects—data fetching, subscriptions, and more"\n\n"The Dependency array determines when useEffect runs"\n\n"useRef holds a value. It''s also used for references to DOM elements"\n\n"useMemo and useCallback are Memoization hooks. They prevent unnecessary recalculations"'
WHERE chapter_id = 8 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Components have a Lifecycle"\n\n"Mount is when a component appears on screen"\n\n"Unmount is when it disappears"\n\n"Render is when a component draws the screen"\n\n"Re-render happens when State or Props change and it redraws"\n\n"Virtual DOM is the secret to React''s speed. Instead of touching the real DOM directly, it calculates differences on a virtual copy"\n\n"Only the parts that changed get updated, making it very efficient"'
WHERE chapter_id = 8 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Conditional rendering changes what''s displayed based on conditions"\n\n"List rendering displays array data repeatedly"\n\n"A Key prop is a unique identifier for each item in a list"\n\n"Without it, React can''t tell which elements have changed"\n\n"A Fragment lets you group elements without adding extra nodes to the DOM"'
WHERE chapter_id = 8 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"As an app grows, State management becomes important"\n\n"Prop drilling is the problem of passing Props through many layers like a bucket brigade"\n\n"One solution is Context"\n\n"Context is a mechanism to share data without using Props"\n\n"A Context provider supplies data, and useContext receives it"\n\n"A Reducer and useReducer manage complex state changes in one place"\n\n"A State store is a centralized place to manage state"\n\n"Lifting state means moving State to a common parent component"'
WHERE chapter_id = 8 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"A Custom hook is an original hook you create yourself"\n\n"The beauty of custom hooks is that they let you reuse logic"\n\n"Hook names must always start with use. That''s a React rule"'
WHERE chapter_id = 8 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"A Controlled component manages form element values with State"\n\n"React has full control over the input values. It makes validation and such much easier"\n\n"Now you''ve mastered the basics of React!"\n\n"Next, let''s go learn about UI component patterns"'
WHERE chapter_id = 8 AND scene_number = 9;

-- =============================================
-- Chapter 9  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the academy, you spotted a workshop filled with colorful parts.\n\n"This is the UI Parts Workshop!"\n\nA stylish woman greeted you.\n\n"I''m Mia, the UI Designer. I''ll teach you how to make user-friendly parts"\n\n"A Page is the whole screen, and a Component is a part within it"\n\n"A Header is the top of a page, and a Footer is the bottom"\n\n"A Navbar is a navigation menu, and a Sidebar is an auxiliary menu on the side"\n\n"Layout is the arrangement pattern of these elements. Navigation is the system for moving between pages"'
WHERE chapter_id = 9 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"A Card is a box that displays information together"\n\nMia showed some samples.\n\n"Social media posts, product listings, profile displays… cards are used everywhere"\n\n"A Button is a part you click to make something happen"\n\n"It''s important that the design makes it obvious it''s clickable"'
WHERE chapter_id = 9 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Form is where users enter information"\n\n"An Input field is the box where you type text"\n\n"A Label is the text that tells you what to enter"\n\n"A Placeholder is a faint hint shown inside the input field"\n\n"Validation checks whether the input is correct"\n\n"An Error message is a warning shown when there''s a problem with the input"\n\n"Submit sends the form''s contents. It triggers when you press the submit button"'
WHERE chapter_id = 9 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"There are all sorts of selection parts too"\n\n"A Checkbox is a square button that lets you select multiple options"\n\n"A Radio button is a round button that lets you select just one"\n\n"A Select is a part that lets you choose from a dropdown"\n\n"A Dropdown menu is a list of options that opens when clicked"\n\n"A Toggle is a switch for turning things ON or OFF"\n\n"A Slider is a part where you drag a handle to select a value"'
WHERE chapter_id = 9 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Parts that communicate to users are also important"\n\n"An Alert is a display that highlights important notices"\n\n"A Notification tells users about new information"\n\n"A Toast is a brief notice that pops up in the corner and disappears automatically"\n\n"Imagine bread popping out of a toaster"\n\n"A Tooltip is a small explanation that appears when you hover over something"'
WHERE chapter_id = 9 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"A Modal is a window displayed on top of the screen"\n\n"It''s also called a Dialog box. It''s used for confirmation messages and input forms"\n\n"A Popup is similar but usually smaller"\n\n"An Overlay darkens the background to make the modal stand out"\n\n"Clicking the overlay to close the modal is a common pattern"'
WHERE chapter_id = 9 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"You shouldn''t leave users waiting with nothing to look at while data loads"\n\n"A Spinner is a spinning loading indicator"\n\n"A Progress bar shows how far along something is"\n\n"A Skeleton loader is a gray placeholder shaped like the content"\n\n"Since you can imagine what will appear, the wait feels shorter"'
WHERE chapter_id = 9 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Let me also introduce parts for organizing information"\n\n"An Accordion is a collapsible section that opens and closes on click"\n\n"It''s commonly used for FAQs"\n\n"Tabs let you switch content in the same space"\n\n"Pagination divides content across multiple pages and provides navigation"'
WHERE chapter_id = 9 AND scene_number = 8;

-- =============================================
-- Chapter 10  (10 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the workshop, you saw a white marble building.\n\n"This is the ''Design Museum''"\nMia guided you in.\n\n"In this chapter, we''ll learn about UI/UX"\n\n"UI is User Interface—the screens and parts that users interact with"\n\n"UX is User Experience—the overall experience a user feels"\n\n"Both visual beauty (UI) and ease of use (UX) are important"'
WHERE chapter_id = 10 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'The first gallery had design plans on display.\n\n"A Wireframe is a blueprint showing only the skeleton of a page"\n\n"You leave out colors and design and focus only on placement"\n\n"A Mockup is a design close to the finished product, with colors and fonts"\n\n"The typical flow is: wireframe → mockup → implementation"'
WHERE chapter_id = 10 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Design system is a set of organized design rules"\n\n"Colors, fonts, spacing, button styles… keeping everything consistent maintains brand coherence"\n\n"A Component library is a collection of reusable parts"\n\n"Design tokens define colors and sizes as variables"\n\n"A Theme is the overall feel of a design"\n\n"Light mode has a bright background, Dark mode has a dark one. These days, offering both is the norm"'
WHERE chapter_id = 10 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The next gallery was filled with rainbow-like colors.\n\n"A Color scheme is the color plan for the entire site"\n\n"Hex color starts with # followed by 6 alphanumeric characters"\n\n"RGB represents colors using three values: red, green, and blue"\n\n"Opacity is transparency. 0 is fully transparent, 1 is fully opaque"'
WHERE chapter_id = 10 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Typography is the field of designing text"\n\n"A Font is a typeface"\n\n"Font family specifies which font to use"\n\n"Font size is the text size, Font weight is the thickness"\n\n"Line height is the height of a line. Around 1.5 to 1.8 is easy to read"\n\n"Google Fonts is a treasure trove of free fonts. They''re easy to use on websites"'
WHERE chapter_id = 10 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"An Icon is a small picture that conveys meaning"\n\n"Lucide dev icons is a popular icon library"\n\n"A Favicon is the small icon displayed in a browser tab"\n\n"Pexels is a free stock photo site for commercial use"\n\n"The More options icon (⋮ or …) opens a menu"\n\n"Home refers to the site''s top page"\n\n"A QR code is a square code that, when scanned with a phone, takes you to a URL"'
WHERE chapter_id = 10 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Parts have various ''states''"\n\n"Hover state is how it looks when the mouse is over it"\n\n"Active state is how it looks while being clicked"\n\n"Focus state is how it looks when selected by keyboard. Very important for accessibility"\n\n"Disabled state is how it looks when it can''t be interacted with. Usually grayed out"'
WHERE chapter_id = 10 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"Here are decoration techniques that enrich design"\n\n"Drop shadow adds a shadow to make an element look like it''s floating"\n\n"Border radius rounds the corners"\n\n"A Gradient is an effect where colors gradually change"\n\n"Combining these creates a sense of depth and dimension"'
WHERE chapter_id = 10 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'"Animations add movement to elements"\n\n"A Transition creates smooth changes between states"\n\n"When you hover, the color smoothly changes—that kind of pleasant movement"\n\n"But don''t overdo it. Too much motion is tiring, and some people get motion sick"\n\n"Animations are like spices. The right amount is what matters"'
WHERE chapter_id = 10 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'"Finally, some basic layout terms"\n\n"A Row is a horizontal line, and a Column is a vertical line"\n\n"In a grid system, you combine rows and columns to create layouts"\n\n"You''ve learned the basics of design. Next, let''s learn how to style efficiently using CSS frameworks"'
WHERE chapter_id = 10 AND scene_number = 10;

-- =============================================
-- Chapter 11  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the museum, you saw a stylish tailor''s shop.\n\n"Welcome! I''m the Tail Craftsman. I''ll teach you techniques for writing CSS efficiently"\n\n"CSS is very flexible, but that makes it hard to manage in large projects"\n\n"That''s where CSS frameworks and various styling methods come in"'
WHERE chapter_id = 11 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Tailwind is the most popular CSS framework right now"\n\n"It''s based on a Utility-first philosophy"\n\n"You combine small classes to build styles"\n\n"You can style everything right in the HTML without writing separate CSS files"\n\n"Once you get the hang of it, you can develop at blazing speed!"'
WHERE chapter_id = 11 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Shadcn is a beautiful component collection based on Tailwind"\n\n"You can copy and paste them, and customize them however you like"\n\n"CSS-in-JS is a technique of writing CSS inside JavaScript"\n\n"CSS modules isolate CSS on a per-component basis"'
WHERE chapter_id = 11 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Sass and SCSS are languages that extend CSS"\n\n"Variables, nesting, mixins… features CSS doesn''t have"\n\n"Being able to write nested styles makes the structure much clearer, doesn''t it?"\n\n"However, browsers can''t read SCSS directly, so it needs to be compiled into CSS"'
WHERE chapter_id = 11 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"CSS variables are a variable feature built into CSS itself"\n\n"Also called Custom properties"\n\n"Define them with names starting with -- and use them with var()"\n\n"They''re great for theme switching. Just change the variable values and the entire site''s colors change"'
WHERE chapter_id = 11 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"The scope of styles is also important"\n\n"Global styles are styles applied across the entire site"\n\n"Scoped styles are styles applied only to a specific component"\n\n"Without proper scoping, styles can leak into unintended places"\n\n"That''s why it''s important to keep styles contained within their component"'
WHERE chapter_id = 11 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Browsers have default styles. But they vary slightly between browsers"\n\n"Reset CSS is an approach that zeros out all default styles"\n\n"Normalize CSS is an approach that evens out browser differences while keeping useful defaults"\n\n"Which one you use is a matter of preference, but some countermeasure is needed"'
WHERE chapter_id = 11 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"PostCSS is a tool for transforming and optimizing CSS"\n\n"You can combine plugins to perform various processes"\n\n"Autoprefixer automatically adds vendor prefixes for browser compatibility"\n\n"It handles old browser support automatically, saving developers a lot of work"'
WHERE chapter_id = 11 AND scene_number = 8;

-- =============================================
-- Chapter 12  (7 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the tailor''s shop, you saw a cave halfway up the mountain.\n\nAn old man with a long white beard stood at the entrance.\n\n"Welcome to the Terminal Cave. I am the Terminal Elder"\n\n"In this cave, I shall teach you how to use the black screen—the terminal"\n\n"Beginners fear the black screen, but once mastered, it becomes the most powerful weapon"'
WHERE chapter_id = 12 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Let''s start with the development environment"\n\n"An IDE is an Integrated Development Environment"\n\n"It''s a tool that combines everything—writing code, running it, debugging…"\n\n"A Code editor is an editor for writing code. Visual Studio Code is popular"\n\n"An IDE is feature-rich; a code editor is simple and lightweight. Each has its strengths"\n\n"A Sandbox is an isolated environment where you can safely try out code without affecting production"'
WHERE chapter_id = 12 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Now, let''s talk about the black screen"\n\n"A Terminal is the screen where you type commands"\n\n"It''s also called the Command line or CLI"\n\n"A Shell is the program that interprets and executes commands"\n\n"Bash is one of the most common shells"\n\n"Sometimes commands are faster than clicking with a mouse"'
WHERE chapter_id = 12 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"There are also modern terminals these days"\n\n"Warp is a modern, user-friendly terminal app"\n\n"AI suggests commands and organizes output into blocks"\n\n"You can even use Warp as a Coding agent—it helps fix and generate code"\n\n"The era of coding alongside AI has arrived"'
WHERE chapter_id = 12 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Browsers also have powerful tools"\n\n"Dev tools are development support features built into browsers"\n\n"Open them with F12 or by right-clicking and choosing Inspect"\n\n"The Console panel shows JavaScript logs and errors"\n\n"The Network panel lets you see communication details"\n\n"The Network log makes it easy to see exactly what requests are being sent"'
WHERE chapter_id = 12 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"A Debugger is a tool that pauses program execution so you can inspect its state"\n\n"A Call stack records the order in which functions were called"\n\n"A Stack trace displays the call history when an error occurs"\n\n"Read it from bottom to top to see what triggered the error"'
WHERE chapter_id = 12 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"When a page is acting up, first try a Refresh"\n\n"If that doesn''t work, try a Hard refresh—a complete reload that ignores the cache"\n\n"Taking a Screenshot to record the error state is also important"\n\n"An Error is a message indicating a problem in the program"\n\n"A Crash is when a program stops completely"\n\n"A Network error occurs when there''s a communication problem"'
WHERE chapter_id = 12 AND scene_number = 7;

-- =============================================
-- Chapter 13  (7 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Emerging from the cave, you found a huge distribution center. Trucks were coming and going.\n\n"Hey! I''m a Package Courier. I deliver useful packages to developers all around the world"\n\n"A Package is a bundle of useful code someone else wrote. Instead of building everything from scratch, using packages saves you time"'
WHERE chapter_id = 13 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"npm stands for Node Package Manager. It''s a package management tool for JavaScript"\n\n"An npm package is a package distributed through npm"\n\n"npm install is the command to download packages"\n\n"npm run is the command to execute scripts"\n\n"npx runs a package temporarily without installing it"'
WHERE chapter_id = 13 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"Yarn is also a popular package manager"\n\n"It does the same things as npm, but the commands are slightly different"\n\n"Which one to use is decided by the team, but functionally they''re almost the same"\n\n"Packages is the plural form—it refers to the many packages used in a project"'
WHERE chapter_id = 13 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"A Dependency is a package your project needs"\n\n"If your project uses React, then React is a dependency"\n\n"A Dev dependency is a package needed only during development"\n\n"Testing tools and code formatting tools fall into this category"'
WHERE chapter_id = 13 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Package.json is a project''s configuration file"\n\n"It lists which packages are used, what scripts are available, and more"\n\n"Package-lock.json is a type of Lock file. It pins exact versions"\n\n"Node modules is the folder containing installed packages"'
WHERE chapter_id = 13 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Semantic versioning is a set of rules for numbering versions"\n\n"1.2.3—Major.Minor.Patch"\n\n"Major is a big change (not backward-compatible), Minor adds features (backward-compatible), Patch is a bug fix"\n\n"If you don''t pin versions, you might end up with ''it worked yesterday but not today!''"'
WHERE chapter_id = 13 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Development has multiple ''environments''"\n\n"A Development environment is where developers write and test code"\n\n"A Staging environment is a near-production environment for testing"\n\n"A Preview environment is a temporary environment for reviewing changes"\n\n"A Production environment is the live environment users actually use"\n\n"An Environment variable is a way to pass different settings for each environment"'
WHERE chapter_id = 13 AND scene_number = 7;

-- =============================================
-- Chapter 14  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the distribution center, you found an old-fashioned library. But inside, countless glowing lines floated like timelines.\n\n"Welcome to the Library of Time. I am the Git Librarian"\n\n"Here, I shall teach you how to record and manage the ''history'' of code"\n\n"Git is a version control system—a tool for recording and managing the history of code changes"'
WHERE chapter_id = 14 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"A Repository is a project''s vault. It contains the code and its entire history"\n\n"GitHub is a service for sharing and managing repositories online"\n\n"Clone means copying a repository to your own computer"\n\n"Fork means copying someone else''s repository to your own account"\n\n"Cloning is like ''borrowing''; forking is like ''making it your own''"'
WHERE chapter_id = 14 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"A Branch is a ''fork in the road'' of development"\n\nYou could see glowing lines branching out.\n\n"The Main branch is the main river—the production code"\n\n"A Feature branch is a branch for developing new features"\n\n"You branch off to develop, then merge back into the main river when done"\n\n"Checkout means switching between branches"'
WHERE chapter_id = 14 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"A Commit is the act of recording a change"\n\n"Think of it as creating a save point"\n\n"The Staging area is the ''preparation zone'' before committing"\n\n"You use git add to stage changes, then git commit to finalize them"\n\n"Write a concise commit message describing what you changed"'
WHERE chapter_id = 14 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Commit, Push, and Pull are the basic flow of Git"\n\n"Push sends your local changes to the remote (GitHub)"\n\n"Pull brings remote changes to your local machine"\n\n"When working in a team: Pull to get the latest, work and Commit, then Push"'
WHERE chapter_id = 14 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"Merge combines branches together"\n\n"A Merge conflict happens when the same spot was edited separately on different branches"\n\n"You need to resolve it manually by choosing which version to keep"\n\n"Rebase is an alternative merge method that moves the starting point of a branch"'
WHERE chapter_id = 14 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"There are other useful commands too"\n\n"Stash temporarily saves your in-progress changes"\n\n"Reset undoes a commit"\n\n"Revert creates a new commit that undoes a previous one"\n\n"Diff shows the changes between versions"\n\n".gitignore specifies which files Git should not track"'
WHERE chapter_id = 14 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"A Pull request is a ''request'' to merge your changes into the main branch"\n\n"You create it on GitHub"\n\n"Code review is when others check your code"\n\n"Once approved, it gets merged"\n\n"GitHub Actions automatically runs tests or deployments triggered by pushes or pull requests"'
WHERE chapter_id = 14 AND scene_number = 8;

-- =============================================
-- Chapter 15  (8 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the Library of Time, a grand castle stood before you.\n\n"Welcome to the Server Castle!"\n\nA knight in armor greeted you.\n\n"I am the Server Guardian. I protect this castle—the Backend"\n\n"The Backend, or Back end, handles the processing that users don''t see"\n\n"A Server is a computer that receives requests and processes them"\n\n"Server side refers to the processing that happens on the server"'
WHERE chapter_id = 15 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"Let me explain the two sides"\n\n"Frontend / Front end is the side users directly interact with—the screen"\n\n"Client side is the processing that runs in the user''s browser"\n\n"Full stack refers to a developer who can do both"'
WHERE chapter_id = 15 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"The castle has many rooms. Deciding which room to lead visitors to is the job of a Route"\n\n"Routes are multiple routes. They''re also called Endpoints"\n\n"A Router directs requests to the appropriate route"\n\n"Route security protects routes so only authenticated users can access them"'
WHERE chapter_id = 15 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"Let me explain how a request is processed"\n\n"A Controller is the command center that receives requests and directs processing"\n\n"A Service handles the Business logic—the actual processing"\n\n"A Model defines the shape of data and communicates with the database"\n\n"A Handler is a function responsible for a specific task"'
WHERE chapter_id = 15 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"Middleware is processing that sits between the request and response"\n\n"It handles authentication checks, logging, data transformation, and more"\n\n"Think of it as a security guard checking IDs at the entrance"'
WHERE chapter_id = 15 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"REST is an API design style"\n\n"RESTful means following the principles of REST"\n\n"Stateless means the server doesn''t remember the client''s state"\n\n"Every time, you include the necessary information in the request"\n\n"A Session temporarily stores a user''s state"\n\n"A Cookie is a small piece of data stored in the browser. It''s used to maintain login state"'
WHERE chapter_id = 15 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"Let''s look at the structure of a request"\n\n"A Header contains supplementary information for the request"\n\n"The Body is the main content—the data being sent"\n\n"Payload is used with the same meaning as Body"'
WHERE chapter_id = 15 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"HTTP methods indicate what you want to do"\n\n"GET means ''I want to retrieve data''"\n"POST means ''I want to create something new''"\n"PUT means ''I want to update something''"\n\n"Using these correctly is the foundation of RESTful API design"\n\n"In the next chapter, we''ll dive deeper into APIs"'
WHERE chapter_id = 15 AND scene_number = 8;

-- =============================================
-- Chapter 16  (9 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'Leaving the Server Castle, you came upon a grand building with flags from all over the world flying.\n\n"This is the API Embassy. I am the API Ambassador"\n\n"API stands for Application Programming Interface—it''s the ''window'' through which software talks to other software"\n\n"Just as an embassy connects countries, APIs connect apps"'
WHERE chapter_id = 16 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'"An API call is a request made to an API"\n\n"An API endpoint is the specific URL of an API"\n\n"An API key is a key that proves you have permission to use the API"\n\n"Without this key, you can''t use the API"\n\n"API keys are secret! Never expose them publicly"'
WHERE chapter_id = 16 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'"CRUD represents the four basic data operations"\n\n"C - Create → POST\nR - Read → GET\nU - Update → PUT\nD - Delete → DELETE"\n\n"You express these through HTTP methods"\n\n"DELETE is the method for removing data"\n\n"A REST API is an API design style that uses these methods"'
WHERE chapter_id = 16 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'"GraphQL is a different API format from REST"\n\n"With a Query, you specify exactly what data you want to retrieve"\n\n"With a Mutation, you modify data"\n\n"REST has fixed data for each URL, but GraphQL lets the client choose what data it needs"'
WHERE chapter_id = 16 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'"A WebSocket is a communication method where the server and client stay constantly connected"\n\n"A Socket is the connection point"\n\n"It enables Real-time data exchange"\n\n"It''s used where instant updates are needed, like chat apps and stock tickers"\n\n"A Real-time Subscription automatically receives data changes. It''s commonly used with GraphQL"'
WHERE chapter_id = 16 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'"A Webhook is a system that automatically sends a notification when an event occurs"\n\n"For example, you register: ''When payment is complete, notify this URL''"\n\n"A Callback is a function that gets called when a process finishes"\n\n"A Callback ID identifies which callback it is"\n\n"Invocation means calling a function or API"'
WHERE chapter_id = 16 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'"APIs have various limitations"\n\n"A Rate limit is a cap on the number of requests allowed in a time period"\n\n"Throttling limits or delays requests"\n\n"Debouncing processes only the last of a series of rapid events"\n\n"A Timeout cuts off processing when there''s no response within a certain time"'
WHERE chapter_id = 16 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'"CORS stands for Cross-Origin Resource Sharing—a mechanism that controls data sharing between different domains"\n\n"For security, access from different domains is blocked by default"\n\n"The server needs to explicitly allow it"\n\n"An SDK is a Software Development Kit—a toolkit that makes it easier to use an API"\n\n"With an SDK, learning to use an API becomes much easier"'
WHERE chapter_id = 16 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'The API Ambassador smiled.\n\n"With this, the journey through 500 terms comes to an end"\n\nBit jumped with joy.\n\n"We did it! You learned them all!"\n\n"You can now understand the language of the programming world"\n\n"But this isn''t the end—it''s the beginning"\n\n"Use this knowledge to actually write code and build apps"\n\n"The words you learned on this journey will surely help you along the way"'
WHERE chapter_id = 16 AND scene_number = 9;

-- =============================================
-- Chapter 17: Epilogue – Memory Garden  (13 scenes)
-- =============================================

UPDATE story_scenes SET content_en = E'After leaving Chapter 16—the API Embassy—you found yourself in a place you''d never seen before.\n\nA field of flowers stretched out in every direction. But the petals were made of light, each one gently flickering.\n\nAnd overhead—countless butterflies were dancing across the sky.\n\n"This is…"\n\n"The Memory Garden"\n\nA familiar voice. You turned around to find Bit and Byte.\n\n"You learned 500 words"\n"That''s why you were able to come here"\n\n"These butterflies are…"\n"The Code Butterflies born each time you learned"\n\n500 butterflies danced around you in celebration.'
WHERE chapter_id = 17 AND scene_number = 1;

UPDATE story_scenes SET content_en = E'Then, a butterfly landed on your hand.\n\n"The journey ends here, but…"\n"The butterflies have a gift for you"\n\n"A gift?"\n\n"When you actually start writing code, there are important words you''re sure to encounter"\n\n"Twenty words we couldn''t cover in the main story, but that we want you to know"\n\nThe butterflies began to descend, one by one.'
WHERE chapter_id = 17 AND scene_number = 2;

UPDATE story_scenes SET content_en = E'The first butterfly softly began to glow.\n\n"Programs sometimes fail"\n\n"But with Try/catch, you''ll be okay"\n\n"You try in the try block and catch the failure in catch"\n\n"Don''t be afraid of failure. As long as you''re prepared to handle it, you can take the leap"\n\nThe next butterfly descended.\n\n"Even ''nothing'' has different types"\n\n"null means ''intentionally empty''"\n\n"undefined means ''nothing has been put in yet''"\n\n"They seem similar, but the meanings differ. Knowing this makes finding bugs much easier"'
WHERE chapter_id = 17 AND scene_number = 3;

UPDATE story_scenes SET content_en = E'The third butterfly glowed gently.\n\n"When accessing deep objects, you''ll get an error if something in the middle is null"\n\n"But with ?. (Optional chaining), it''s safe"\n\n"Think of it like politely knocking and asking ''are you there?'' as you go"\n\nThe fourth butterfly followed.\n\n"Nullish coalescing is the ?? operator that provides a fallback when the value is null or undefined"\n\nThe fifth.\n\n"A Template literal uses backticks to embed variables in strings"\n\nThe sixth.\n\n"The Ternary operator is condition ? when true : when false—a shorthand for if-else"'
WHERE chapter_id = 17 AND scene_number = 4;

UPDATE story_scenes SET content_en = E'The seventh butterfly glowed warmly.\n\n"Want to save data in the browser? You can use localStorage"\n\n"localStorage is a mechanism for storing data in the browser"\n\n"It persists even after closing the browser. Great for saving theme settings or favorites"\n\n"But it can only store strings, so convert objects to JSON first"'
WHERE chapter_id = 17 AND scene_number = 5;

UPDATE story_scenes SET content_en = E'The eighth, ninth, tenth, and eleventh butterflies descended together.\n\n"Let me teach you about CSS layout"\n\n"Flexbox is a layout for arranging elements in a row"\n\n"Grid is powerful for two-dimensional layouts. You can place elements in rows and columns like spreadsheet cells"\n\n"z-index determines which element appears in front when they overlap. The higher the number, the closer to the front"\n\n"The Box model—every element is made of four layers: content, padding, border, and margin"'
WHERE chapter_id = 17 AND scene_number = 6;

UPDATE story_scenes SET content_en = E'The twelfth and thirteenth butterflies descended together.\n\n"You want things to look good on phones and PCs—that''s Responsive design"\n\n"It adapts the layout to the screen size"\n\n"A Breakpoint (CSS) is the boundary where the layout changes"\n\n"Starting with small screens—''Mobile first''—is recommended"'
WHERE chapter_id = 17 AND scene_number = 7;

UPDATE story_scenes SET content_en = E'The fourteenth butterfly settled quietly.\n\n"HTTP responses come back with a number"\n\n"Status code—200 is OK, 404 is not found, 500 is server error"\n\n"4xx means ''your side has a problem,'' 5xx means ''the server has a problem''"\n\n"With these numbers, you can tell what happened"'
WHERE chapter_id = 17 AND scene_number = 8;

UPDATE story_scenes SET content_en = E'The fifteenth, sixteenth, seventeenth, and eighteenth butterflies descended in succession.\n\n"Let''s get your creation out to the world"\n\n"Deploy means publishing your app. You put your code on a server so anyone can access it"\n\n"Hosting means renting a place to publish your site. Vercel, Netlify, AWS… there are many services"\n\n"A Domain is the address of a site, like example.com"\n\n"SSL / HTTPS encrypts communication. Sites that start with https:// have encrypted traffic. These days, HTTPS is a must"'
WHERE chapter_id = 17 AND scene_number = 9;

UPDATE story_scenes SET content_en = E'The nineteenth butterfly rested on your shoulder.\n\n"SEO—Search Engine Optimization"\n\n"You want to appear near the top when someone searches on Google, right?"\n\n"Title, description, page structure, loading speed… there are many ways to make your site more discoverable"\n\n"But the most important thing is to create great content"'
WHERE chapter_id = 17 AND scene_number = 10;

UPDATE story_scenes SET content_en = E'And then—the last butterfly descended. The 500th butterfly. It was noticeably large and shone beautifully.\n\n"Accessibility is the consideration that makes things usable by everyone"\n\n"People with low vision, people who are hard of hearing, people who can''t use a mouse… making sure everyone can enjoy what you create"\n\n"This isn''t something you add at the end—it''s something you keep in mind from the start"\n\nThe butterfly spoke gently.\n\n"Building for everyone. That''s what truly beautiful code is"'
WHERE chapter_id = 17 AND scene_number = 11;

UPDATE story_scenes SET content_en = E'Twenty butterflies danced around you. Then, all 500 butterflies soared high into the sky.\n\nA vortex of light enveloped the entire garden.\n\n"You learned 520 words"\n\nBit smiled brightly.\n\n"But this isn''t the end"\n\nByte continued.\n\n"Just knowing the words doesn''t mean you can speak the language yet"\n\n"You have to actually write code, fail, and write again…"\n\n"Only then do the words become ''power''"\n\n"But you''re not afraid anymore, right?"\n"Because you know the words"\n"Because you know where to start"\n\n"We''ll always be with you"\n\n"Goodbye, traveler"\n"And—"\n"Welcome back, engineer"'
WHERE chapter_id = 17 AND scene_number = 12;

UPDATE story_scenes SET content_en = E'When the light faded—you found yourself sitting in front of your own computer.\n\nOn the screen was an empty editor. And a blinking cursor.\n\nGlancing out the window—just for a moment, you thought you saw a glowing butterfly.\n\nNo, you definitely saw one.\n\nYou smiled and placed your hands on the keyboard.\n\nYou typed the first line into the editor.\n\nconst greeting = "Hello, World!";\nconsole.log(greeting);\n\nYou pressed the run button.\n\n    Hello, World!\n\nThe moment the text appeared on screen—you felt a tiny butterfly take flight in your heart.\n\n"Now then, what shall I build?"\n\nWith 520 words and 520 butterflies, your true journey begins.'
WHERE chapter_id = 17 AND scene_number = 13;
