# 第4章：プログラミング道場

**〜 命令の作法を学ぶ 〜**

**カテゴリ：プログラミング基礎（Programming Fundamentals）**
**登場用語：Syntax, Statement, Expression, Operator, Assignment, Declaration, Function, Method, Parameter, Parameters, Argument, Return value, Scope, Local scope, Global scope, Block scope, Closure, Callback, Loop, Iteration, Conditional, If/else, Switch statement, Ternary operator, Truthy, Falsy, Comparison operator, Logical operator, Concatenation, Interpolation, Template literal, Comment, Debug, Breakpoint, Exception, Error handling, Try/catch, Line (in code), Instructions, Hierarchy, Modularity, Readability, Granularity, Inline coding, Feature aware code**

---

## シーン1：道場の門

```
「さあ、いよいよプログラミングの本格的な
修行が始まるよ！」

ビットくんと一緒に、
古風な道場の門をくぐった。

「ようこそ、プログラミング道場へ」

道着姿の女性が出迎えた。
ループちゃんという名前らしい。

「ここでは、コードの『作法』を学びます。
正しい作法を知れば、
コンピュータに正確に命令を伝えられますよ」
```

---

## シーン2：文法のお稽古

```
「まず、Syntax（シンタックス・構文）から」

ループちゃんが筆で書いた。

「Syntax は、プログラミング言語の文法です。
人間の言葉に『てにをは』があるように、
プログラムにも書き方のルールがあります」

「Statement（文）は、命令の1文。
Expression（式）は、値を生み出す部分です」

let x = 5 + 3;
    └─式─┘
└──文──────┘

「Operator（演算子）は、
+、-、×、÷のような記号。
計算や比較を行います」

「= は Assignment（代入）。
右側の値を、左側の変数に入れる、
という意味です」
```

**💡 用語登場：Syntax, Statement, Expression, Operator, Assignment**

---

## シーン3：関数という技

```
「プログラミングの必殺技、
Function（関数）を教えましょう」

function greet(name) {
  return "こんにちは、" + name + "さん！";
}

「関数は、命令をまとめて名前をつけたものです。
一度作れば、何度でも呼び出せます」

「Parameter（パラメータ・仮引数）は、
関数を作るときに用意する『受け取り口』」

「Argument（引数）は、
関数を使うときに渡す『実際の値』」

greet("ビットくん");  // "ビットくん"がArgument
       ↑
    Argumentを渡す

「Return value（戻り値）は、
関数が返してくれる結果です」

「Method（メソッド）は、
オブジェクトに属する関数のことです」
```

**💡 用語登場：Function, Method, Parameter, Argument, Return value, Declaration**

---

## シーン4：スコープの掟

```
「Scope（スコープ）は、
変数が見える範囲のことです」

ループちゃんが図を描いた。

「Global scope（グローバルスコープ）は、
プログラム全体から見える範囲」

「Local scope（ローカルスコープ）は、
関数の中だけで見える範囲」

「Block scope（ブロックスコープ）は、
{ } の中だけで見える範囲」

let global = "全員が見える";

function test() {
  let local = "この中だけ";

  if (true) {
    let block = "ここだけ";
  }
}

「Closure（クロージャ）は、
関数が外側の変数を覚えている仕組み。
少し難しいですが、とても便利です」
```

**💡 用語登場：Scope, Global scope, Local scope, Block scope, Closure**

---

## シーン5：繰り返しの修行

```
「私の得意技、Loop（ループ・繰り返し）です！」

ループちゃんが嬉しそうに実演した。

for (let i = 0; i < 5; i++) {
  console.log("繰り返し " + i + "回目");
}

「同じことを何度も書かなくていい。
これがループの力です」

「Iteration（イテレーション）は、
繰り返しの1回分のこと。
5回ループなら、5回のイテレーションです」

「Callback（コールバック）は、
『これが終わったら呼んでね』と
渡しておく関数のこと。
非同期処理でよく使います」
```

**💡 用語登場：Loop, Iteration, Callback**

---

## シーン6：条件分岐の術

```
「Conditional（条件分岐）も大切な技です」

「If/else は最も基本的な条件分岐。
もし〜なら、そうでなければ……」

if (score >= 80) {
  console.log("合格！");
} else {
  console.log("もう少し！");
}

「Switch statement（switch文）は、
複数の選択肢から選ぶとき便利です」

「Ternary operator（三項演算子）は、
if/elseを1行で書く省略形」

const result = score >= 80 ? "合格" : "不合格";
               条件        ? 真    : 偽

「条件分岐で、プログラムは
状況に応じた動きができるようになります」
```

**💡 用語登場：Conditional, If/else, Switch statement, Ternary operator**

---

## シーン7：真と偽の世界

```
「条件分岐で重要なのが、
Truthy と Falsy の概念です」

「Truthy は、条件として『真』と見なされる値。
Falsy は、『偽』と見なされる値です」

// Falsy な値（これらは偽と判定される）
false, 0, "", null, undefined, NaN

// 上記以外は全部 Truthy（真と判定される）
"hello", 1, [], {}

「Comparison operator（比較演算子）は、
===、!==、<、>などで値を比較」

「Logical operator（論理演算子）は、
&&（かつ）、||（または）、!（否定）」

if (age >= 18 && hasTicket) {
  console.log("入場できます");
}
```

**💡 用語登場：Truthy, Falsy, Comparison operator, Logical operator**

---

## シーン8：文字列の技

```
「文字列を操作する技も覚えましょう」

「Concatenation（連結）は、
文字列をつなげること」

"Hello" + " " + "World"  // "Hello World"

「でも今は、Template literal（テンプレートリテラル）
を使う方が便利です」

const name = "ビットくん";
const message = `こんにちは、${name}さん！`;

「バッククォート ` で囲んで、
${} の中に変数を入れる。
これを Interpolation（補間）といいます」

「読みやすくて、間違いも減りますね」
```

**💡 用語登場：Concatenation, Interpolation, Template literal**

---

## シーン9：エラーと向き合う

```
「プログラミングにエラーはつきもの。
でも、上手に付き合う方法があります」

「Comment（コメント）は、
コードに残すメモ。
実行されないので、説明を書けます」

// これは1行コメント
/* これは
   複数行コメント */

「Debug（デバッグ）は、
バグ（不具合）を見つけて直すこと」

「Breakpoint（ブレークポイント）は、
プログラムを途中で止める印。
止めて中身を確認できます」

「Exception（例外）は、
予想外のエラーが起きること。
Try/catch で安全に処理します」

try {
  // 危険かもしれない処理
} catch (error) {
  // エラーが起きたらここで対処
}
```

**💡 用語登場：Comment, Debug, Breakpoint, Exception, Error handling, Try/catch**

---

## シーン10：良いコードの心得

```
「最後に、良いコードを書くための心得です」

ループちゃんが巻物を広げた。

「Readability（可読性）——
他の人が読んでもわかるコードを」

「Modularity（モジュール性）——
機能ごとに分けて、再利用しやすく」

「Hierarchy（階層構造）——
整理された構造で見通しよく」

「Granularity（粒度）——
関数は1つの仕事だけするように」

「Line（行）ごとに Instructions（命令）を書き、
Feature aware code（機能を意識したコード）を
心がけましょう」

「Inline coding（インラインコーディング）は
避けて、きちんと関数に分けること」

「これらを守れば、
バグが少なく、保守しやすい
コードが書けますよ」
```

**💡 用語登場：Readability, Modularity, Hierarchy, Granularity, Line, Instructions, Inline coding, Feature aware code**

---

## 第4章クリア！

```
🎉 おめでとう！第4章をクリアしました！

【習得した用語】45語
✅ Syntax, Statement, Expression, Operator, Assignment, Declaration
✅ Function, Method, Parameter, Parameters, Argument, Return value
✅ Scope, Local scope, Global scope, Block scope, Closure, Callback
✅ Loop, Iteration, Conditional, If/else, Switch statement, Ternary operator
✅ Truthy, Falsy, Comparison operator, Logical operator
✅ Concatenation, Interpolation, Template literal
✅ Comment, Debug, Breakpoint, Exception, Error handling, Try/catch
✅ Line, Instructions, Hierarchy, Modularity, Readability
✅ Granularity, Inline coding, Feature aware code

【次の冒険へ】
第5章「Webページ建設現場」が解放されました！
HTMLとCSSで、目に見えるものを作りましょう。
```

---
