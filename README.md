# ComicUpdateViewer+

## 概要
* 漫画サイトの更新を確認するアプリケーション
  * webサイトを用意して一覧できるようにする
  * webPushを使って更新を通知できるようにする
* [このアプリケーション](https://github.com/EIMIKI/ComicUpdateViewer)の作り直し＋α

## 環境
### Rubyバージョン
* 2.5.3
### Railsバージョン
* 5.2.1
### 環境変数
* VAPID_PUBLIC_KEY = "webpushに使うvapidの公開鍵"
* VAPID_PRIVATE_KEY = "webpushに使うvapidの秘密鍵"
  
## 導入
1. $ git clone https://github.com/EIMIKI/cuv_plus.git
2. $ cd cuv_plus
3. $ bundle install
4. $ rails db:migrate
5. $ rails vapid:generate
6. $ rails vapid:set
7. $ rails s

## その他
### スクレイピングによる更新の取得
* $ rails get_update
### Webpushによるプッシュ通知の送信
* $ rails send_push
