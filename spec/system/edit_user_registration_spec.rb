require 'rails_helper'

RSpec.describe 'EditUserRegistration', type: :system do
  it 'ユーザー情報を編集する', js: true do
    user = FactoryBot.create(:user,
                             username: 'sample',
                             email: 'sample@sample.com',
                             profile: 'My name is sample.',
                             password: '123456')
    user.confirm

    # ログインする
    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    fill_in 'メールアドレス', with: 'sample@sample.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'

    # パスワード以外の変更であれば、現在のパスワードの入力を求められないこと
    click_link 'プロフィール編集'
    attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/test.jpg", make_visible: true
    fill_in 'ユーザーネーム', with: 'alice'
    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in '自己紹介', with: 'My name is alice.'
    click_button '変更を保存する'
    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content 'アカウント情報が更新されました。更新の確認メールを新しいメールアドレス宛に送信しましたので、リンクを開いて更新を有効にして下さい。'

    user.reload
    user.confirm # メールアドレス認証
    aggregate_failures do
      expect(user.username).to eq 'alice'
      expect(user.email).to eq 'alice@alice.com'
      expect(user.profile).to eq 'My name is alice.'
    end

    # パスワードの変更であれば、現在のパスワードの入力を求めること
    fill_in 'パスワード', with: 'abcdef'
    fill_in 'パスワードの再入力', with: 'abcdef'
    click_button '変更を保存する'
    expect(page).to have_content '現在のパスワードを入力してください'
    expect(user.reload.valid_password?('abcdef')).to_not eq true

    visit edit_user_registration_path # リロード
    fill_in 'パスワード', with: 'abcdef'
    fill_in 'パスワードの再入力', with: 'abcdef'
    fill_in '現在のパスワード', with: '123456'
    click_button '変更を保存する'
    expect(page).to have_content '変更が保存されました'
    expect(user.reload.valid_password?('abcdef')).to eq true
  end
end