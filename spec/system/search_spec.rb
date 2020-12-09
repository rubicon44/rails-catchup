require 'rails_helper'

RSpec.describe 'Search', type: :system do
  it '投稿/ユーザーを検索する', js: true do
    goal1 = FactoryBot.create(:goal, name: 'test title1')
    goal2 = FactoryBot.create(:goal, name: 'Test Title2')
    goal3 = FactoryBot.create(:goal, name: 'テスト タイトル3')

    user1 = FactoryBot.create(:user, username: 'alice', email: 'alice@alice.com', password: '123456')
    user2 = FactoryBot.create(:user, username: 'boby', email: 'boby@boby.com', password: '123456')
    user3 = FactoryBot.create(:user, username: 'costa', email: 'costa@costa.com', password: '123456')

    visit root_path
    # 未ログイン
    ## 未ログイン状態でも検索できること
    ### 目標検索
    fill_in 'q[name_or_description_cont]', with: 'title'
    click_button '検索'
    expect(page).to have_content 'test title1'
    expect(page).to have_content 'Test Title2'
    expect(page).to_not have_content 'テスト タイトル3'

    ### ユーザー検索
    click_link 'ユーザー一覧'
    expect(current_path).to eq users_path
    fill_in 'q[username_cont]', with: 'a'
    click_button '検索'
    expect(page).to have_content 'alice'
    expect(page).to_not have_content 'boby'
    expect(page).to have_content 'costa'

    # ログイン
    ## ログインする
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path

    fill_in 'ユーザーネーム/メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'

    # 投稿を検索
    visit root_path # リロード
    fill_in 'q[name_or_description_cont]', with: 'title'
    click_button '検索'
    expect(page).to have_content 'test title1'
    expect(page).to have_content 'Test Title2'
    expect(page).to_not have_content 'テスト タイトル3'

    # ユーザーを検索
    click_link 'ユーザー一覧'
    expect(current_path).to eq users_path
    fill_in 'q[username_cont]', with: 'a'
    click_button '検索'
    expect(page).to have_content 'alice'
    expect(page).to_not have_content 'boby'
    expect(page).to have_content 'costa'
  end
end
