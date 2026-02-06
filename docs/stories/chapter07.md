# 第7章：JavaScript道場

**〜 Webに命を吹き込む術 〜**

**カテゴリ：JavaScript & TypeScript**
**登場用語：JavaScript, TypeScript, ES6, ECMAScript, Let, Const, Arrow function, Async, Await, Promise, Fetch, Then/catch, Spread operator, Destructuring, Module, Import, Export, Default export, Named export, Barrel exports, This keyword, Event, Event listener, Event handler, Prevent default, setTimeout, setInterval, Map function, Filter function, Reduce function, ForEach, Find, Console log, Get, Typeof, Node.js, Zod, Library import, Utility, Parsing**

---

## シーン1：道場への入門

```
港を離れ、山の上の道場に着いた。
「JavaScript道場」と書かれた門がある。

「ここで Web に動きを加える術を学ぶんだ」
とビットくん。

白髪の師範が出迎えた。

「ようこそ。私は JS マスター。
JavaScript（ジャバスクリプト）の
奥義を伝授しよう」

「JavaScript は Web ページに
命を吹き込む言語だ。
ボタンをクリックしたら何かが起きる、
そういう動きを作れる」

「TypeScript（タイプスクリプト）は、
JavaScript に『型』を加えた改良版。
より安全にコードが書ける」
```

**💡 用語登場：JavaScript, TypeScript**

---

## シーン2：変数の術

```
「ES6（イーエスシックス）は、
2015年に登場した JavaScript の
大きなアップデートだ」

「ECMAScript（エクマスクリプト）は
JavaScript の正式名称。
ES6 は正確には ECMAScript 2015 のことだ」

「Let と Const は、変数を宣言する術」

let count = 0;      // 変更できる
const MAX = 100;    // 変更できない

「Arrow function（アロー関数）は、
関数を短く書く新しい書き方だ」

// 従来の書き方
function add(a, b) {
  return a + b;
}

// アロー関数
const add = (a, b) => a + b;

「=> の形が矢印（アロー）に見えるだろう」
```

**💡 用語登場：ES6, ECMAScript, Let, Const, Arrow function**

---

## シーン3：非同期の術

```
「Web では『待つ』処理が多い。
データを取ってくる間、
止まっていては困るだろう」

「Promise（プロミス）は、
『将来の結果を約束する』仕組みだ」

「Async/Await（アシンク/アウェイト）は、
Promise を読みやすく書く術」

async function getData() {
  const response = await fetch(url);
  const data = await response.json();
  return data;
}

「Fetch（フェッチ）は、
サーバーからデータを取得する術」

「Then/catch は Promise を扱う
従来の書き方だ」

fetch(url)
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error));
```

**💡 用語登場：Promise, Async, Await, Fetch, Then/catch**

---

## シーン4：便利な記法

```
「ES6 で追加された便利な記法を教えよう」

「Spread operator（スプレッド演算子）は、
配列やオブジェクトを展開する」

const arr1 = [1, 2, 3];
const arr2 = [...arr1, 4, 5];  // [1, 2, 3, 4, 5]

「Destructuring（分割代入）は、
配列やオブジェクトから値を取り出す」

const { name, age } = person;
const [first, second] = array;

「これらを使いこなせば、
コードがぐっと短くなる」
```

**💡 用語登場：Spread operator, Destructuring**

---

## シーン5：モジュールの術

```
「大きなプログラムは
Module（モジュール）に分ける」

「Import は他のファイルから取り込む」
「Export は他のファイルに公開する」

// math.js
export const add = (a, b) => a + b;
export default function multiply(a, b) {
  return a * b;
}

// main.js
import multiply, { add } from './math.js';

「Default export（デフォルトエクスポート）は
ファイルの主役を1つだけ公開」

「Named export（名前付きエクスポート）は
複数の機能を名前をつけて公開」

「Barrel exports は、
複数のモジュールを1箇所にまとめて
再エクスポートする技だ」

「Library import（ライブラリインポート）で
便利な外部ライブラリも使える」
```

**💡 用語登場：Module, Import, Export, Default export, Named export, Barrel exports, Library import**

---

## シーン6：イベントの術

```
「Event（イベント）は、
何かが起きたときの知らせだ」

「クリック、キー入力、スクロール……
ユーザーの操作はすべてイベントになる」

「Event listener（イベントリスナー）は、
イベントを監視する見張り番」

「Event handler（イベントハンドラー）は、
イベントが起きたときの処理内容」

button.addEventListener('click', () => {
  console.log('クリックされた！');
});

「Prevent default（プリベントデフォルト）は、
ブラウザの標準動作を止める術」

form.addEventListener('submit', (e) => {
  e.preventDefault();  // ページ遷移を防ぐ
});

「This keyword は、
今どのオブジェクトを指しているかを表す。
文脈によって変わるので注意が必要だ」
```

**💡 用語登場：Event, Event listener, Event handler, Prevent default, This keyword**

---

## シーン7：タイマーの術

```
「時間を操る術もある」

「setTimeout は、
指定時間後に1回だけ実行」

setTimeout(() => {
  console.log('3秒経った！');
}, 3000);

「setInterval は、
指定間隔で繰り返し実行」

setInterval(() => {
  console.log('1秒ごとに実行');
}, 1000);

「Web ページで時計を動かしたり、
定期的にデータを取得したりできる」
```

**💡 用語登場：setTimeout, setInterval**

---

## シーン8：配列操作の術

```
「配列を操る強力な術を教えよう」

「Map function（マップ関数）は、
全要素を変換して新しい配列を作る」

[1, 2, 3].map(x => x * 2);  // [2, 4, 6]

「Filter function（フィルター関数）は、
条件に合う要素だけを抽出」

[1, 2, 3, 4, 5].filter(x => x > 2);  // [3, 4, 5]

「Reduce function（リデュース関数）は、
全要素を1つの値にまとめる」

[1, 2, 3, 4].reduce((sum, x) => sum + x, 0);  // 10

「ForEach は全要素に処理を実行」
「Find は条件に合う最初の要素を返す」

「これらを組み合わせれば、
複雑なデータ処理も簡潔に書ける」
```

**💡 用語登場：Map function, Filter function, Reduce function, ForEach, Find**

---

## シーン9：デバッグの術

```
「Console log（コンソールログ）は、
デバッグの基本中の基本だ」

console.log('ここを通過');
console.log('変数の値:', value);

「Get は値を取得すること、
Typeof は型を確認する術だ」

console.log(typeof 42);        // "number"
console.log(typeof "hello");   // "string"

「Parsing（パージング）は、
文字列を解析してデータに変換すること」

JSON.parse('{"name":"test"}');  // オブジェクトに変換

「Zod は TypeScript で
データの形を検証するライブラリだ」

「Utility（ユーティリティ）は、
便利な補助関数のことだ」
```

**💡 用語登場：Console log, Get, Typeof, Parsing, Zod, Utility**

---

## シーン10：Node.js

```
「JavaScript はブラウザの中だけでなく、
サーバーでも動かせる」

「Node.js（ノードジェイエス）は、
JavaScript をサーバーで動かす環境だ」

「これのおかげで、
フロントエンドもバックエンドも
JavaScript で書けるようになった」

「次の章では React を学ぶ。
JavaScript の知識を活かして、
もっと複雑な UI を作れるようになるぞ」

「ありがとうございました、師匠！」
```

**💡 用語登場：Node.js**

---

## 第7章クリア！

```
🎉 おめでとう！第7章をクリアしました！

【習得した用語】40語
✅ JavaScript, TypeScript, ES6, ECMAScript
✅ Let, Const, Arrow function, Async, Await, Promise
✅ Fetch, Then/catch, Spread operator, Destructuring
✅ Module, Import, Export, Default export, Named export, Barrel exports
✅ This keyword, Event, Event listener, Event handler, Prevent default
✅ setTimeout, setInterval
✅ Map function, Filter function, Reduce function, ForEach, Find
✅ Console log, Get, Typeof, Node.js, Zod, Library import, Utility, Parsing

【次の冒険へ】
第8章「コンポーネント学園」が解放されました！
Reactでモダンな UI を作りましょう。
```

---
