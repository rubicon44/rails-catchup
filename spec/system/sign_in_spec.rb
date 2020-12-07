require 'rails_helper'

RSpec.describe 'SignIn', type: :system do
  it 'ユーザーネームとメールアドレスのどちらでもログインできること', js: true do
    FactoryBot.create(:user,
                      username: 'sample',
                      email: 'sample@sample.com',
                      profile: 'My name is sample.',
                      password: '123456')

    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'

    # ログインに失敗する場合
    click_button 'ログイン'
    expect(page).to have_content \
      '入力されたユーザーネームやパスワードが正しくありません。'

    fill_in 'メールアドレス', with: 'sample@sample.com'
    fill_in 'パスワード', with: 'abcdef'
    click_button 'ログイン'
    expect(page).to have_content \
      '入力されたユーザーネームやパスワードが正しくありません。'

    # ログインに成功する場合
    ## メールアドレスを使ってログインする
    visit current_path
    fill_in 'メールアドレス', with: 'sample@sample.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'
    ## ログイン後のフラッシュメッセージを確認
    expect(page).to have_content 'ログインしました。'

    ## ログアウト後のフラッシュメッセージを確認
    expect(page).to have_button 'ログアウト'
    click_button 'ログアウト'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ログアウトしました。'

    # # ユーザーネームを使ってログインする
    # fill_in 'ユーザーネーム/メールアドレス', with: 'sample'
    # fill_in 'パスワード', with: '123456'
    # click_button 'ログイン'
    # expect(page).to have_content 'フィード'
  end

  # todo: 「メール認証」機能を実装する
  # it 'メールアドレスが未承認のユーザーではログインできないこと' do
  #   FactoryBot.create(:user, :unconfirmed, username: 'sample', password: '123456')

  #   visit new_user_session_path
  #   expect(page).to have_content 'ログイン状態を保持'

  #   fill_in 'ユーザーネーム/メールアドレス', with: 'sample'
  #   fill_in 'パスワード', with: '123456'
  #   click_button 'ログインする'
  #   expect(page).to have_content 'アカウントが有効化されていません。'
  # end

  # todo: 「ゲストログイン」機能を実装する
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

  it '管理ユーザーとしてログインする', js: true do
    admin = FactoryBot.create(:user, :admin)
    user = FactoryBot.create(:user)
    # guest = FactoryBot.create(:user, :guest)

    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'
    fill_in 'メールアドレス', with: 'admin@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'

    # 管理ユーザーのユーザー詳細ページが正しく表示されていること
    click_link 'プロフィール'
    expect(page).to have_content '管理者'
    expect(page).to have_content '名前：admin'

    # 管理ユーザーは通常のユーザーを削除できること
    visit user_path(user)
    expect(page).to have_button 'このユーザーを削除する'
    expect(page).to have_button 'フォローする'

    expect do
      click_button 'このユーザーを削除する'
      expect(page.driver.browser.switch_to.alert.text).to eq 'このユーザーを削除してもよろしいですか?'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'ユーザーは正常に削除されました。'
    end.to change(User, :count).by(-1)

    # # 管理ユーザーはゲストユーザーを削除できないこと
    # visit user_path(guest)
    # expect(page).to_not have_content 'このユーザーを削除する'
    # expect(page).to_not have_content 'プロフィールを編集'
  end
end
