# 第8章：コンポーネント学園

**〜 部品を組み合わせてUIを作る 〜**

**カテゴリ：React & コンポーネント開発**
**登場用語：React, React component, Functional component, JSX, TSX, Props, State, useState, useEffect, useContext, useRef, useMemo, useCallback, Custom hook, Hook, Lifecycle, Mount, Unmount, Render, Re-render, Virtual DOM, Conditional rendering, List rendering, Key prop, Children prop, Fragment, Context, Context provider, Reducer, useReducer, State management, State store, Global state, Local state, Prop drilling, Lifting state, Controlled component, Side effect, Dependency array, Memoization**

---

## シーン1：学園の門

```
山を下りると、
モダンな校舎が見えてきた。

「コンポーネント学園へようこそ！」

若い女性教師が出迎えた。

「私はリアクト先生。
React（リアクト）という
UI構築ライブラリを教えています」

「React は Facebook が作った
人気のライブラリです。
UI を『部品』に分けて作るのが特徴よ」

「React component（コンポーネント）が
その『部品』のこと。
小さな部品を組み合わせて、
大きな画面を作っていくの」
```

**💡 用語登場：React, React component**

---

## シーン2：コンポーネントの基本

```
「Functional component（関数コンポーネント）が
現在の主流よ」

function Greeting() {
  return <h1>こんにちは！</h1>;
}

「JSX（ジェイエスエックス）は、
JavaScript の中に HTML のような
記法を書ける仕組み」

「TSX は TypeScript 版の JSX よ」

「見た目は HTML みたいだけど、
実際は JavaScript なの」

const element = (
  <div className="card">
    <h1>タイトル</h1>
    <p>本文です</p>
  </div>
);

「class ではなく className を使うのが
JSX のルールよ」
```

**💡 用語登場：Functional component, JSX, TSX**

---

## シーン3：データの受け渡し

```
「Props（プロップス）は、
親から子へデータを渡す方法よ」

function Welcome({ name }) {
  return <h1>ようこそ、{name}さん！</h1>;
}

<Welcome name="ビットくん" />

「Children prop（チルドレンプロップ）は、
タグの中身を渡す特別な Props よ」

<Card>
  <p>この中身が children</p>
</Card>

「State（ステート）は、
コンポーネント自身が持つ
変化するデータのこと」

「Local state（ローカルステート）は
そのコンポーネントだけのデータ、
Global state（グローバルステート）は
アプリ全体で共有するデータよ」
```

**💡 用語登場：Props, Children prop, State, Local state, Global state**

---

## シーン4：フックの魔法

```
「Hook（フック）は、
関数コンポーネントに
機能を追加する魔法よ」

「useState は State を使うフック」

const [count, setCount] = useState(0);

<button onClick={() => setCount(count + 1)}>
  カウント: {count}
</button>

「useEffect は Side effect（副作用）——
データ取得や購読などを扱うフック」

useEffect(() => {
  console.log('コンポーネントが表示された');
}, []);

「Dependency array（依存配列）は、
useEffect がいつ実行されるかを決める」

「useRef は値を保持するフック。
DOM要素への参照にも使うわ」

「useMemo と useCallback は
Memoization（メモ化）のフック。
不要な再計算を防ぐの」
```

**💡 用語登場：Hook, useState, useEffect, Side effect, Dependency array, useRef, useMemo, useCallback, Memoization**

---

## シーン5：ライフサイクル

```
「コンポーネントには
Lifecycle（ライフサイクル）があるの」

「Mount（マウント）は、
コンポーネントが画面に表示されるとき」

「Unmount（アンマウント）は、
画面から消えるとき」

「Render（レンダー）は、
コンポーネントが画面を描画すること」

「Re-render（再レンダー）は、
State や Props が変わって描き直すこと」

「Virtual DOM（仮想DOM）は、
React の高速化の秘密。
実際のDOMを直接触らず、
仮想的なコピーで差分を計算するの」

「変わった部分だけを更新するから、
とても効率的なのよ」
```

**💡 用語登場：Lifecycle, Mount, Unmount, Render, Re-render, Virtual DOM**

---

## シーン6：条件とリスト

```
「Conditional rendering（条件付きレンダー）は、
条件によって表示を変えること」

{isLoggedIn ? <Dashboard /> : <Login />}

「List rendering（リストレンダー）は、
配列のデータを繰り返し表示すること」

{items.map(item => (
  <li key={item.id}>{item.name}</li>
))}

「Key prop（キープロップ）は、
リストの各要素につける
ユニークな識別子よ」

「これがないと React が
どの要素が変わったか判断できないの」

「Fragment（フラグメント）は、
余計な要素を追加せずにまとめる方法」

<>
  <Header />
  <Content />
</>
```

**💡 用語登場：Conditional rendering, List rendering, Key prop, Fragment**

---

## シーン7：状態管理

```
「アプリが大きくなると、
State management（状態管理）が重要になるわ」

「Prop drilling（プロップドリリング）は、
何層も Props をバケツリレーする問題」

「解決策のひとつが Context よ」

「Context（コンテキスト）は、
Props を使わずにデータを共有する仕組み」

「Context provider（プロバイダー）で
データを提供して、
useContext で受け取るの」

「Reducer（リデューサー）と useReducer は、
複雑な状態変更をまとめて管理する方法」

「State store（ステートストア）は、
状態を一箇所にまとめて管理する場所よ」

「Lifting state（ステートの持ち上げ）は、
共通の親に State を移動させること」
```

**💡 用語登場：State management, Prop drilling, Context, Context provider, useContext, Reducer, useReducer, State store, Lifting state**

---

## シーン8：カスタムフック

```
「Custom hook（カスタムフック）は、
自分で作るオリジナルのフックよ」

function useCounter(initial = 0) {
  const [count, setCount] = useState(initial);
  const increment = () => setCount(c => c + 1);
  const decrement = () => setCount(c => c - 1);
  return { count, increment, decrement };
}

// 使い方
const { count, increment } = useCounter(10);

「ロジックを再利用できるのが
カスタムフックの魅力よ」

「フック名は必ず use で始めること。
これが React のルールよ」
```

**💡 用語登場：Custom hook**

---

## シーン9：制御されたコンポーネント

```
「Controlled component（制御されたコンポーネント）は、
フォーム要素の値を State で管理すること」

const [value, setValue] = useState('');

<input
  value={value}
  onChange={(e) => setValue(e.target.value)}
/>

「入力値を React が完全にコントロールするの。
バリデーションなどがしやすくなるわ」

「これで React の基礎は完璧よ！」

「次は UI コンポーネントのパターンを
学びに行きましょう」
```

**💡 用語登場：Controlled component**

---

## 🦋 第8章クリア！【前編完了】

```
🎉 おめでとう！第8章をクリアしました！
   前編（第1章〜第8章）完了！

【習得した用語】40語
✅ React, React component, Functional component, JSX, TSX
✅ Props, State, useState, useEffect, useContext, useRef
✅ useMemo, useCallback, Custom hook, Hook
✅ Lifecycle, Mount, Unmount, Render, Re-render, Virtual DOM
✅ Conditional rendering, List rendering, Key prop, Children prop, Fragment
✅ Context, Context provider, Reducer, useReducer
✅ State management, State store, Global state, Local state
✅ Prop drilling, Lifting state, Controlled component
✅ Side effect, Dependency array, Memoization
```

🦋 **メモリーガーデンへの道が見えてきました！**

```
ふと気づくと、いつの間にか何十匹もの蝶が
あなたの周りを舞っていた。

大きく成長した蝶、まだ小さな蝶、
色とりどりの光が、まるで祝福するように輝いている。

「すごい……！もうこんなに」
バイトさんが目を丸くする。

「260匹だね」ビットくんが数えた。
「きみの知識が、ちゃんと蝶になってる」

遠くに見えるメモリーガーデンが、
前より少しだけ近づいた気がした。

「もう半分まで来たんだ。
後半も一緒に頑張ろうね！」
```

**🦋 蝶の数：260 / 500**

【後編へ続く】
第9章「UIパーツ工房」が解放されました！

---
