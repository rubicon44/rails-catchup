require 'rails_helper'

RSpec.describe 'SignIn', type: :system do
  it 'ユーザーネームとメールアドレスのどちらでもログインできること', js: true do
    FactoryBot.create(:user, username: 'alice', email: 'alice@alice.com', password: '123456')

    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'

    # ログインに失敗する場合
    click_button 'ログインする'
    expect(page).to have_content \
      '入力されたユーザーネームやパスワードが正しくありません。'

    fill_in 'ユーザーネーム/メールアドレス', with: 'sample'
    fill_in 'パスワード', with: 'foobar'
    click_button 'ログインする'
    expect(page).to have_content \
      '入力されたユーザーネームやパスワードが正しくありません。'

    # ユーザーネームを使ってログインする
    fill_in 'ユーザーネーム/メールアドレス', with: 'sample'
    fill_in 'パスワード', with: '123456'
    click_button 'ログインする'
    expect(page).to have_content 'フィード'

  #   # ログイン後のフラッシュメッセージが生成されないことを確認
  #   expect(page).to_not have_content 'ログインしました。'

  #   click_on 'nav avatar image'
  #   expect(page).to have_content 'ログアウト'

  #   find('a.logout').click
  #   expect(page).to have_content 'ログアウトしますか？'

  #   click_on 'ログアウト'
  #   expect(current_path).to eq root_path

  #   click_link 'ログイン'
  #   expect(current_path).to eq new_user_session_path
  #   expect(page).to have_content 'ログイン状態を保持'

  #   # ログアウト後のフラッシュメッセージが生成されないことを確認
  #   expect(page).to_not have_content 'ログアウトしました。'

  #   # メールアドレスを使ってログインする
  #   fill_in 'ユーザーネーム/メールアドレス', with: 'sample@example.com'
  #   fill_in 'パスワード', with: '123456'
  #   click_button 'ログインする'
  #   expect(page).to have_content 'フィード'
  # end

  # it 'メールアドレスが未承認のユーザーではログインできないこと' do
  #   FactoryBot.create(:user, :unconfirmed, username: 'sample', password: '123456')

  #   visit new_user_session_path
  #   expect(page).to have_content 'ログイン状態を保持'

  #   fill_in 'ユーザーネーム/メールアドレス', with: 'sample'
  #   fill_in 'パスワード', with: '123456'
  #   click_button 'ログインする'
  #   expect(page).to have_content 'アカウントが有効化されていません。'
  # end

  # it 'ゲストユーザーとしてログインする', js: true do
  #   guest = FactoryBot.create(:user, :guest)

  #   visit root_path
  #   expect(page).to have_content 'こちらからゲストユーザーとしてログインできます'

  #   find('nav.signin-as-guest').click
  #   expect(page).to have_content 'ゲストユーザーとしてログインしますか？'

  #   click_button 'ログイン'
  #   expect(page).to have_content 'フィード'

  #   click_on 'nav avatar image'
  #   expect(page).to have_content 'ログアウト'

  #   # ゲストユーザーはユーザー情報の編集ができないこと
  #   click_button 'プロフィールを編集'
  #   expect(page).to have_content 'ゲストユーザーは利用できません'

  #   visit edit_user_registration_path
  #   expect(current_path).to eq root_path
  # end

  # it '管理ユーザーとしてログインする', js: true do
  #   admin = FactoryBot.create(:user, :admin)
  #   user = FactoryBot.create(:user)
  #   guest = FactoryBot.create(:user, :guest)

  #   visit root_path

  #   click_link 'ログイン'
  #   expect(current_path).to eq new_user_session_path
  #   expect(page).to have_content 'ログイン状態を保持'

  #   fill_in 'ユーザーネーム/メールアドレス', with: 'admin'
  #   fill_in 'パスワード', with: '123456'
  #   click_button 'ログインする'
  #   expect(page).to have_content 'フィード'

  #   # 管理ユーザーのユーザー詳細ページが正しく表示されていること
  #   click_on 'nav avatar image'
  #   expect(page).to have_content 'プロフィールを編集'
  #   expect(page).to have_content 'ログアウト'

  #   # 管理ユーザーは通常のユーザーを削除できること
  #   visit user_path(user)
  #   expect(page).to have_content 'このユーザーを削除する'
  #   expect(page).to_not have_content 'プロフィールを編集'
  #   expect(page).to_not have_content 'ログアウト'

  #   find('a.btn.delete').click
  #   expect do
  #     click_link '削除'
  #   end.to change(User, :count).by(-1)
  #   expect(page).to have_content 'ユーザーは正常に削除されました'

  #   # 管理ユーザーはゲストユーザーを削除できないこと
  #   visit user_path(guest)
  #   expect(page).to_not have_content 'このユーザーを削除する'
  #   expect(page).to_not have_content 'プロフィールを編集'
  # end
end
