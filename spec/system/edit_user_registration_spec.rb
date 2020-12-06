require 'rails_helper'

RSpec.describe 'EditUserRegistration', type: :system do
  it 'ユーザー情報を編集する', js: true do
    user = FactoryBot.create(:user,
                             username: 'alice',
                             email: 'alice@alice.com',
                             profile: 'Hello',
                             password: '123456')

    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'

    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'
    # expect(page).to have_content 'フィード'
    click_link 'プロフィール編集'

    # パスワード以外の変更であれば、現在のパスワードの入力を求められないこと
    attach_file 'user[avatar]', "#{Rails.root}/spec/fixtures/test.jpg", make_visible: true
    fill_in 'ユーザーネーム', with: 'alice'
    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in '自己紹介', with: 'Hello'
    click_button '変更を保存する'
    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content '変更が保存されました'

    # user.reload
    # aggregate_failures do
    #   expect(user.name).to eq 'Alice'
    #   expect(user.bio).to eq 'LOVE Coffee and Dogs'
    #   expect(user.username).to eq 'alice'
    #   expect(user.email).to eq 'alice@example.com'
    # end

    # # パスワードの変更であれば、現在のパスワードの入力を求めること
    # fill_in 'パスワード', with: 'abcdef'
    # fill_in 'パスワードの再入力', with: 'abcdef'
    # click_button '変更を保存する'
    # expect(page).to have_content '現在のパスワードが入力されていません'
    # expect(user.reload.valid_password?('abcdef')).to_not eq true

    # fill_in 'パスワード', with: 'abcdef'
    # fill_in 'パスワードの再入力', with: 'abcdef'
    # fill_in '現在のパスワード', with: '123456'
    # click_button '変更を保存する'
    # expect(page).to have_content '変更が保存されました'
    # expect(user.reload.valid_password?('abcdef')).to eq true
  end
end