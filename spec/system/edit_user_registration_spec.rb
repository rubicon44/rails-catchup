require 'rails_helper'

RSpec.describe 'EditUserRegistration', type: :system do
  it 'ユーザー情報を編集する', js: true do
    user = FactoryBot.create(:user,
                             username: 'sample',
                             email: 'sample@sample.com',
                             profile: 'My name is sample.',
                             password: '123456')

    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'
    fill_in 'メールアドレス', with: 'sample@sample.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'
    # expect(page).to have_content 'フィード'

    # パスワード以外の変更であれば、現在のパスワードの入力を求められないこと
    click_link 'プロフィール編集'
    attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/test.jpg", make_visible: true
    fill_in 'ユーザーネーム', with: 'alice'
    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in '自己紹介', with: 'My name is alice.'
    click_button '変更を保存する'
    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content '変更が保存されました'

    user.reload
    aggregate_failures do
      expect(user.username).to eq 'alice'
      expect(user.email).to eq 'alice@alice.com'
      expect(user.profile).to eq 'My name is alice.'
    end

    # パスワードの変更であれば、現在のパスワードの入力を求めること
    fill_in 'パスワード', with: 'abcdefgh'
    fill_in 'パスワードの再入力', with: 'abcdefgh'
    click_button '変更を保存する'
    expect(page).to have_content '現在のパスワードを入力してください'
    expect(user.reload.valid_password?('abcdefgh')).to_not eq true

    fill_in 'パスワード', with: 'abcdefgh'
    fill_in 'パスワードの再入力', with: 'abcdefgh'
    fill_in '現在のパスワード', with: '123456'
    click_button '変更を保存する'
    expect(page).to have_content '変更が保存されました'
    expect(user.reload.valid_password?('abcdefgh')).to eq true
  end
end