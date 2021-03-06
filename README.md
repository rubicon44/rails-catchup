[![Maintainability](https://api.codeclimate.com/v1/badges/e810fbc574e0fa186a6b/maintainability)](https://codeclimate.com/github/rubicon44/rails-catchup/maintainability)

# 概要
RailsCatchupは、転職用ポートフォリオとして制作したタスク管理SNSです。

【サービスの目的】

大きく分けて3つです。

- 周りの人の目標の立て方、タスクの立て方等を学ぶ
- 周りの人の成長から刺激を受ける
- 自身のタスクを積み上げ成長する

自身がプログラミングを独学する中で、他人がどのように目標を立て、タスクを実行しているのかが気になりました。

周りのあらゆる人から学ぶことで、自身の成長を最大化させることができます。

## URL
サービスURL：http://rails-catchup-lb-821719903.ap-northeast-1.elb.amazonaws.com

- 画面上部のバーから【ゲストユーザー】としてログインできます。
- ユーザーネーム"admin"、パスワード"adminadmin"で【管理ユーザー】としてログインできます。管理ユーザーは、他の一般ユーザーのアカウントや投稿を削除する権限を持ちます。
- ゲスト/管理ユーザーのユーザー情報の編集は禁止しています。ご了承ください。

## アピールポイント
- Ruby・Railsによる基本的なCRUDを実装できている
- 開発環境・本番環境にDockerを用いて開発を行っている
- テストをしっかりと記述している
- CI/CDパイプラインを構築している
- AWSで、基本的な本番環境を構築している

## 使用技術
【バックエンド】
- Ruby 2.6.3
- Ruby on Rails 5.2.4
- Puma

【フロントエンド】
- Sass
- jQuery

【テスト】
- Rspec
- Rubocop

【CI/CD】
- Circle CI

【その他】
- Docker
- Docker Compose

【インフラ】
- AWS
  - VPC、その他基本機能
  - ECR
  - ECS
  - RDS
  - ALB
  ~~- Route 53~~→未実装

## DB設計図（Cacoo使用）
![ER図 Grow-Sns（Railsのみ）-1](https://user-images.githubusercontent.com/47108632/106648252-5dbb6880-65d3-11eb-98bd-cb5083d10006.png)

## AWS構成図（Cacoo使用）
準備中

## 機能一覧
- ログイン機能/ユーザー登録機能（Devise）
- タスク管理機能
  - 登録（Title、Content、Statusの3つを登録可能）
  - 一覧表示
  - 詳細表示
  - 編集
  - 削除
- コメント機能
- いいね機能
- 通知機能
- フォロー機能
- 検索機能（Ransack）
  - タスク検索
  - ユーザー検索
~~- ページネーション機能（Kaminari）~~→未実装
- 管理ユーザー機能（一般ユーザーのアカウントを削除可能）

# 今回の開発を終えての所感
今回はRuby on Railsを用いた、基本的なアプリケーション作成方法を学ぶことができた。

一番大変だったことは、運用を考えながら保守性の高いソースコードを書くこと。
まだまだ自分には運用の力が足りないと思ったため、もっと保守性の高いサービスを作れるようになりたいと思った。

また、Rails以外にLaravelやDjango等のフレームワーク/言語にも触れ、状況に応じた技術選定/開発ができるようになりたい。

次回は、Rails API + React（Vue.js）によるSPA開発/API開発を行いたい。
