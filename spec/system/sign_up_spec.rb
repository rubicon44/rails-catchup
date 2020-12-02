require 'rails_helper'

RSpec.describe 'SignUp', type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end

  def extract_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  it 'ユーザーを作成したあと、確認メールからアカウントを有効化してログインする' do
    # 新規登録

    # 登録に失敗する場合

    # 登録に成功する場合
  end

  it '再送信された確認メールからアカウントを有効化してログインする' do
    # データ作成
  end
end
