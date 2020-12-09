require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  it 'ユーザーをフォロー/フォロー解除する', js: true do
    user1 = FactoryBot.create(:user, username: 'alice', email: 'alice@alice.com', password: '123456')
    user2 = FactoryBot.create(:user, username: 'boby', email: 'boby@boby.com', password: '123456')

    # ログインする
    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'

    fill_in 'ユーザーネーム/メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'
    # expect(page).to have_content 'フィード'

    # フォロー
    ## フォローするユーザーのプロフィールページに遷移し、フォローする
    visit user_path(user2)
    expect(page).to have_content "名前：#{user2.username}"

    expect do
      click_button 'フォローする'
      expect(page).to have_button 'フォロー中'

      click_link 'フォロワー'
      expect(page).to have_content 'フォロワー：1人'
      expect(page).to have_content "名前:#{user1.username}"
    end.to change(user1.followings, :count).by(1) &
           change(user2.followers, :count).by(1)

    visit user_path(user2) # リロード
    expect(page).to_not have_content "名前:#{user1.username}"

    ## 現在のユーザーのプロフィールページに遷移
    click_link 'プロフィール'
    expect(current_path).to eq user_path(user1)
    expect(page).to have_content "名前：#{user1.username}"
    # expect(page).to have_content 'ログアウト'

    click_link 'フォロー'
    expect(page).to have_content 'フォロー中：1人'
    expect(page).to have_content "名前:#{user2.username}"

    # フォロー解除
    ## フォローするユーザーのプロフィールページに遷移
    visit user_path(user2)
    expect(page).to have_content "名前：#{user2.username}"

    expect do
      click_button 'フォロー中'
      expect(page).to have_button 'フォロー'

      click_link 'フォロワー'
      expect(page).to have_content 'フォロワー：0人'
      expect(page).to_not have_content "名前:#{user1.username}"
    end.to change(user1.followings, :count).by(-1) &
           change(user2.followers, :count).by(-1)

    visit user_path(user2) # リロード
    expect(page).to_not have_content "名前:#{user1.username}"

    ## 現在のユーザーのプロフィールページに遷移
    click_link 'プロフィール'
    expect(current_path).to eq user_path(user1)
    expect(page).to have_content "名前：#{user1.username}"
    # expect(page).to have_content 'ログアウト'

    click_link 'フォロー'
    expect(page).to have_content 'フォロー中：0人'
    expect(page).to_not have_content "名前:#{user2.username}"
  end
end
