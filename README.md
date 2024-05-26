## 推しTube
推しTubeは**時間指定のできるYouTubeブックマーク**です。  
動画URLと再生開始時間を登録すればボタン1つで好きなタイミングから何度でも再生できます。  
<br>

## サービスURL
https://oshitube-d4f71351453c.herokuapp.com  
<br>

## 開発背景
私はアイドルやお笑いが好きでよくYouTubeを見るのですが、  
**「この曲のこの瞬間が好きで何度でも見たい！」**  
**「○分○秒から好きな芸人さんのネタが始まるからそのタイミングから再生したい！」**  
と思うことがよくあります。  
  
コメント欄に開始時間を記入すればリンクが作成されるのですが、公開されるものではなく個人的に管理できるサービスがあれば…と以前から感じていました。  
プログラミングの学習をする中で自分で作ることができるのではと思い、ポートフォリオとして作成することにしました。  
<br>

## 機能紹介
- ユーザー登録機能
- ログイン/ログアウト機能
- ゲストログイン機能
- 退会機能（論理削除）
- パスワード再設定機能
- ブックマーク登録機能
- URLから動画タイトル・概要欄・サムネイルを取得（YouTube Data API v3を使用）
- タイムスタンプ登録機能
- カテゴリー作成・分類機能
- ブックマークの公開・非公開の設定  
公開ブックマークサンプル：https://oshitube-d4f71351453c.herokuapp.com/bookmarks/23
<br>

## 使用イメージ
ブックマーク登録・タイムスタンプ登録の流れです。  
タイムスタンプを登録するとボタンが作成され、クリックすることで指定した時間から動画を再生することができます。  

https://github.com/minamimishima/oshitube/assets/146907532/4799a421-0c94-4346-ac2f-654f8df2c949

<br>

## 使用技術
| カテゴリ | 技術 |
| ---- | ---- |
| バックエンド | Ruby 3.2.3 / Rails 7.1.3 |
| フロントエンド | Hotwire / Bootstrap |
| データベース | PostgreSQL |
| 環境構築 | Docker |
| CI/CD | GitHub Actions |
| インフラ | Heroku / Amazon S3 |
| コード解析・リンター | Rubocop / ERB Lint / Brakeman |
| テストフレームワーク | RSpec |
| API | YouTube Data API v3 |
| 認証 | devise |
<br>
<br>

## ER図
![ER図_resize](https://github.com/minamimishima/oshitube/assets/146907532/30a2f0ea-b506-4af2-847a-d2d0b9d84a58)
<br>
<br>

## インフラ構成図
![インフラ構成図_resize240521](https://github.com/minamimishima/oshitube/assets/146907532/9a5e1227-2e97-4fc1-ab2c-bef254f87324)
