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
プログラミングを学習する中で自分で作ることができるのではと思い、ポートフォリオとして作成することにしました。  
<br>

## 機能紹介
### メイン機能・使用画面
| トップページ| ブックマーク登録 |
| ---- | ---- |
| ![トップページ](https://github.com/minamimishima/oshitube/assets/146907532/358553c4-c89a-45f0-b3a5-9506bbc8b1eb) | ![ブックマーク登録](https://github.com/minamimishima/oshitube/assets/146907532/533537bc-0572-408a-9b9f-572884f4738c) |
| サービスの紹介と使い方説明動画を表示しています。 | YouTubeの動画URLを登録すると動画タイトル・サムネイル・概要欄を取得します。 |

<br>

| タイムスタンプ作成 | タイムスタンプ機能 |
| ----| ---- |
| ![タイムスタンプ作成](https://github.com/minamimishima/oshitube/assets/146907532/2a3da6c2-b5e5-44e4-966e-ad4a8bdd72c2) | ![タイムスタンプ使用イメージ](https://github.com/minamimishima/oshitube/assets/146907532/384a3638-d936-40e4-b170-34967168cb1f) |
| 再生を開始したい時間を登録するとその時間から再生を開始できるボタンが作成されます。 | 作成されたボタンをクリックすると登録した時間から動画が再生されます。 |

<br>

| カテゴリー作成① | カテゴリー作成② |
| ---- | ---- |
| ![カテゴリー作成①](https://github.com/minamimishima/oshitube/assets/146907532/476a8653-f383-4409-9b4c-73b816fb346d) | ![カテゴリー作成②](https://github.com/minamimishima/oshitube/assets/146907532/ab0a93db-fd83-4106-acf4-b4802d40bc30) |
| ブックマーク一覧ページから新規カテゴリーを作成できます。 | ブックマーク登録画面から新規カテゴリーを作成できます。 |

<br>

| カテゴリー登録① | カテゴリー登録② |
| ---- | ----|
| ![カテゴリー登録①](https://github.com/minamimishima/oshitube/assets/146907532/df98eb18-8dd0-40a1-a666-798ba32aa860) | ![カテゴリー登録②](https://github.com/minamimishima/oshitube/assets/146907532/2321c4eb-dced-4f6c-b2f5-0eb9f74fd732) |
| ブックマーク登録時にカテゴリーを選択し、登録できます。 | ブックマーク編集画面からカテゴリーを選択し、登録できます。 |

<br>

### 機能一覧
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

#### 公開ブックマークサンプル（プロフィールページ）
- [サンプル①](https://oshitube-d4f71351453c.herokuapp.com/users/5)
- [サンプル②](https://oshitube-d4f71351453c.herokuapp.com/users/3)
- [サンプル③](https://oshitube-d4f71351453c.herokuapp.com/users/6)
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

## 今後の課題・実装したい機能
- Googleアカウントでのログイン機能
- ブックマークした動画の検索機能
- 動画のソート機能
- SNSでの共有機能

現在は最低限の機能のみ実装しているため、今後はより使いやすいアプリになるよう機能を追加していきたいと考えています。  
また、多くの方に使っていただきたいので、Googleログイン機能やSNSでの共有機能も実装したいと考えています。
