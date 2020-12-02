require 'rails_helper'

RSpec.describe 'EditUserRegistration', type: :system do
  it 'ユーザー情報を編集する', js: true do
    # データ作成
    # ログイン
    # プロフィール編集画面に遷移

    # パスワード以外の変更であれば、現在のパスワードの入力を求められないこと（正常に登録できるか）
    # パスワードの変更であれば、現在のパスワードの入力を求められること（正常に登録できるか）
  end
end
