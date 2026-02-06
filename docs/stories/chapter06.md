# 第6章：インターネットの海

**〜 世界をつなぐ道と住所 〜**

**カテゴリ：URL・リンク・HTTP**
**登場用語：URL, Link, Hyperlink, Anchor tag, Href, Path parameter, Query string, Query parameter, Domain, Subdomain, DNS, IP address, Port, HTTP, HTTPS, SSL/TLS, Protocol, Request, Response, Status code, 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 500 Internal Server Error, RSS, SMTP, Egress, Ingress**

---

## シーン1：港に到着

```
建設現場を抜けると、
大きな港が広がっていた。

「ここはインターネットの海への入り口だよ」

船のそばに立つ男性が手を振った。

「やあ！私はルーター船長。
この海を渡って、世界中の
サーバーとつながる手助けをしている」

「インターネットは、
世界中のコンピュータがつながった
巨大なネットワークなんだ」
```

---

## シーン2：住所の仕組み

```
「まず、URL（ユーアールエル）を教えよう」

船長が地図を広げた。

https://www.example.com:443/path?name=test#section
└プロトコル┘   └ドメイン┘ └ポート┘ └パス┘└クエリ┘└フラグメント┘

「URL は Uniform Resource Locator——
インターネット上の住所だ」

「Domain（ドメイン）は
example.com のような、覚えやすい名前」

「Subdomain（サブドメイン）は
www のような、ドメインの前につく部分」

「実際のコンピュータは
IP address（IPアドレス）という
数字の住所を持っている」

192.168.1.1  ← IPアドレスの例

「DNS（ディーエヌエス）は、
ドメイン名をIPアドレスに変換する
電話帳のようなものだ」
```

**💡 用語登場：URL, Domain, Subdomain, IP address, DNS**

---

## シーン3：リンクの力

```
「Link（リンク）は、
ページとページをつなぐ橋だ」

「Hyperlink（ハイパーリンク）とも呼ぶ。
クリックすると別のページに飛べる」

「HTML では Anchor tag（アンカータグ）
<a> を使って作る」

<a href="https://example.com">リンク</a>

「Href（エイチレフ）属性に、
飛び先の URL を指定するんだ」

「Path parameter（パスパラメータ）は
/users/123 のように、URLのパスに含める値」

「Query string（クエリ文字列）は
?name=test&age=20 のように、
? 以降に追加する情報」

「Query parameter（クエリパラメータ）は
その中の name=test のような
ひとつひとつのペアのことだ」
```

**💡 用語登場：Link, Hyperlink, Anchor tag, Href, Path parameter, Query string, Query parameter**

---

## シーン4：通信のルール

```
「船が港に入るとき、
決まったルールがあるように、
インターネットにも Protocol（プロトコル）がある」

「HTTP（エイチティーティーピー）は、
Webページを取得するためのルールだ」

「HTTPS（エイチティーティーピーエス）は、
HTTP に暗号化を加えたもの。
SSL/TLS という技術で安全に通信する」

「Port（ポート）は、
通信の『窓口番号』のようなもの。
HTTP は 80番、HTTPS は 443番を使う」

「南京錠マーク 🔒 が出ていれば、
HTTPS で安全に通信している証拠だ」
```

**💡 用語登場：Protocol, HTTP, HTTPS, SSL/TLS, Port**

---

## シーン5：リクエストとレスポンス

```
「通信は Request（リクエスト）と
Response（レスポンス）の
やり取りで成り立っている」

船長が図を描いた。

ブラウザ ──Request──→ サーバー
         「このページをください」

ブラウザ ←──Response── サーバー
         「はい、どうぞ」

「ブラウザがサーバーに『お願い』を送り、
サーバーが『返事』を返す。
この繰り返しでWebは動いている」

「Ingress（イングレス）は入ってくる通信、
Egress（イーグレス）は出ていく通信のことだ」
```

**💡 用語登場：Request, Response, Ingress, Egress**

---

## シーン6：ステータスコード

```
「サーバーからの返事には
Status code（ステータスコード）がつく」

「200 OK は『成功！問題なし』」

「400 Bad Request は
『お願いの仕方が間違っている』」

「401 Unauthorized は
『ログインが必要です』」

「403 Forbidden は
『アクセス権限がありません』」

「404 Not Found は
『お探しのページは見つかりません』」

「500 Internal Server Error は
『サーバー側で問題が起きた』」

「3桁の数字を見れば、
何が起きたかすぐわかるんだ」
```

**💡 用語登場：Status code, 200 OK, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 500 Internal Server Error**

---

## シーン7：その他のプロトコル

```
「HTTP 以外にも、
目的別のプロトコルがある」

「RSS（アールエスエス）は、
ブログの更新情報を配信する仕組みだ。
好きなサイトの新着を
まとめてチェックできる」

「SMTP（エスエムティーピー）は、
メールを送るためのプロトコルだ」

「それぞれの役割に合わせて、
最適なプロトコルが使われているんだ」
```

**💡 用語登場：RSS, SMTP**

---

## 第6章クリア！

```
🎉 おめでとう！第6章をクリアしました！

【習得した用語】30語
✅ URL, Link, Hyperlink, Anchor tag, Href
✅ Path parameter, Query string, Query parameter
✅ Domain, Subdomain, DNS, IP address, Port
✅ HTTP, HTTPS, SSL/TLS, Protocol
✅ Request, Response, Status code
✅ 200 OK, 400 Bad Request, 401 Unauthorized
✅ 403 Forbidden, 404 Not Found, 500 Internal Server Error
✅ RSS, SMTP, Egress, Ingress

【次の冒険へ】
第7章「JavaScript道場」が解放されました！
Webに動きを加える力を学びましょう。
```

---
