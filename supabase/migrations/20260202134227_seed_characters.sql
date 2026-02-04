/*
  # Seed Characters Data
  
  ## Overview
  Populates the characters table with all DIGITARIA characters
  from the story. Includes main characters and chapter-specific guides.
  
  ## Characters Added
  - Main: ビットくん, バイトさん
  - Chapter guides: ファイラ, ストラクト博士, etc.
  
  ## Notes
  - Uses fixed UUIDs for reliable foreign key references
  - chapter_appearance indicates first appearance
*/

-- Main Characters
INSERT INTO characters (id, name, name_en, role, personality, speech_style, appearance, chapter_appearance)
VALUES 
  (
    '11111111-1111-1111-1111-111111111111',
    'ビットくん',
    'Bit-kun',
    'メインガイド',
    '好奇心旺盛、明るく元気、初心者に優しい',
    '〜だよ、〜なんだ（カジュアルな丁寧語）',
    '0と1が交互に点滅する小さな光の球体',
    0
  ),
  (
    '22222222-2222-2222-2222-222222222222',
    'バイトさん',
    'Byte-san',
    'ビットくんの先輩',
    '穏やか、頼りになる、まとめ役',
    '〜です、〜ですね（丁寧語）',
    '8つの光が集まった、少し大きな存在',
    1
  )
ON CONFLICT (id) DO NOTHING;

-- Chapter-specific Guides
INSERT INTO characters (id, name, name_en, role, personality, speech_style, chapter_appearance)
VALUES 
  (
    '33333333-3333-3333-3333-333333333333',
    'ファイラ',
    'Filer',
    '図書館司書',
    '知的で落ち着いている',
    '〜です、〜ですね（丁寧語）',
    2
  ),
  (
    '44444444-4444-4444-4444-444444444444',
    'ストラクト博士',
    'Dr. Struct',
    'データ構造研究所の所長',
    '研究熱心で論理的',
    '〜です、〜ですよ（丁寧な解説調）',
    3
  ),
  (
    '55555555-5555-5555-5555-555555555555',
    'ループちゃん',
    'Loop-chan',
    '道場の修行者',
    '元気で繰り返しが大好き',
    '〜だよ！〜なの！（元気な口調）',
    4
  ),
  (
    '66666666-6666-6666-6666-666666666666',
    'HTMLくん',
    'HTML-kun',
    'タグ兄弟（兄）',
    '几帳面で構造を大切にする',
    '〜だよ、〜なんだ',
    5
  ),
  (
    '77777777-7777-7777-7777-777777777777',
    'CSSちゃん',
    'CSS-chan',
    'タグ兄弟（妹）',
    '美的センスがあり装飾好き',
    '〜よ、〜なの（女性的な口調）',
    5
  ),
  (
    '88888888-8888-8888-8888-888888888888',
    'ルーター船長',
    'Captain Router',
    '船の船長',
    '豪快で頼りになる船乗り',
    '〜だ、〜だぞ（男性的で力強い）',
    6
  ),
  (
    '99999999-9999-9999-9999-999999999999',
    'JSマスター',
    'JS Master',
    'JavaScript道場の師範',
    '厳格だが愛情深い',
    '〜じゃ、〜だぞ（師範らしい口調）',
    7
  ),
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'リアクト先生',
    'React-sensei',
    'コンポーネント学園の教師',
    '親切で分かりやすく教える',
    '〜よ、〜わ（優しい女性教師）',
    8
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    'UIデザイナー・ミア',
    'UI Designer Mia',
    'インターフェース職人',
    '美的センス抜群、細部にこだわる',
    '〜よ、〜ね（落ち着いた女性）',
    9
  ),
  (
    'cccccccc-cccc-cccc-cccc-cccccccccccc',
    'テイル職人',
    'Tail Craftsman',
    'Tailwindスタイルの仕立て屋',
    '効率を重視する職人気質',
    '〜だ、〜さ（職人らしい口調）',
    11
  ),
  (
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    'ターミナルじいさん',
    'Terminal Grandpa',
    'コマンドの達人',
    '経験豊富で昔話が好き',
    '〜じゃ、〜のう（老人口調）',
    12
  ),
  (
    'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
    'パッケージ配達員',
    'Package Deliverer',
    'npmの荷物を届ける配達員',
    '明るく働き者',
    '〜だよ、〜ね（フレンドリー）',
    13
  ),
  (
    'ffffffff-ffff-ffff-ffff-ffffffffffff',
    'ギット管理人',
    'Git Manager',
    '歴史を記録する時の番人',
    '几帳面で歴史を大切にする',
    '〜だ、〜です（落ち着いた口調）',
    14
  ),
  (
    '00000000-0000-0000-0001-000000000001',
    'サーバー守護者',
    'Server Guardian',
    'バックエンドの城を守る騎士',
    '勇敢で責任感がある',
    '〜だ、〜である（騎士らしい口調）',
    15
  ),
  (
    '00000000-0000-0000-0002-000000000002',
    'API大使',
    'API Ambassador',
    '世界をつなぐ外交官',
    '外交的で礼儀正しい',
    '〜です、〜ございます（丁寧な外交官）',
    16
  )
ON CONFLICT (id) DO NOTHING;
