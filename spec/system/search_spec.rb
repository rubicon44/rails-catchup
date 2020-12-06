require 'rails_helper'

RSpec.describe 'Search', type: :system do
  it '投稿/ユーザーを検索する', js: true do
    goal1 = FactoryBot.create(:goal, name: 'test title1')
    goal2 = FactoryBot.create(:goal, name: 'Test Title2')
    goal3 = FactoryBot.create(:goal, name: 'テスト タイトル3')

    user1 = FactoryBot.create(:user, username: 'alice', email: 'alice@alice.com', password: '123456')
    user2 = FactoryBot.create(:user, username: 'boby', email: 'boby@boby.com', password: '123456')

    visit root_path

    # 未ログイン
    ## 未ログイン状態でも検索できること
    fill_in 'q_name_or_description_cont', with: 'title'
    click_button '検索'
    # todo: 下記は「検索ページ」を「目標一覧」と別にした時に使用。
    # expect(current_path).to eq search_goals_path
    expect(page).to have_content 'test title1'
    expect(page).to have_content 'Test Title2'
    expect(page).to_not have_content 'テスト タイトル3'

    # todo: ユーザー検索機能（未ログイン）
    # click_link 'ユーザー'
    # expect(current_path).to eq search_users_path
    # expect(page).to have_css '#q_username_cont'

    # ログイン
    ## ログインする
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'

    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'
    # expect(page).to have_content 'フィード'

    # 投稿を検索
    fill_in 'q_name_or_description_cont', with: 'title'
    click_button '検索'
    # todo: 下記は「検索ページ」を「目標一覧」と別にした時に使用。
    # expect(current_path).to eq search_goals_path
    expect(page).to have_content 'test title1'
    expect(page).to have_content 'Test Title2'
    expect(page).to_not have_content 'テスト タイトル3'

    # # ユーザーを検索
    # click_link 'ユーザー'
    # expect(current_path).to eq search_users_path
    # expect(page).to have_css '#q_username_cont'
    # fill_in 'ユーザーを検索', with: 'alice'
    # find('#q_username_cont').native.send_key(:return)
    # expect(page).to have_content '@alice'
    # expect(page).to_not have_content '@bobx'
  end
end
