require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  it '投稿をいいね/いいね解除する', js: true do
    goal = FactoryBot.create(:goal, name: 'テスト タイトル')
    user = FactoryBot.create(:user, username: 'alice', email: 'alice@alice.com', password: '123456')
    user.confirm

    # ログインする
    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    fill_in 'ユーザーネーム/メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'

    # 投稿にいいねをする
    visit goal_path(goal)
    expect(page).to have_content 'テスト タイトル'
    expect(page).to have_content 'いいね件数：0'

    expect do
      click_link 'いいね'
      expect(page).to have_content 'いいね件数：1'
      expect(page).to have_link 'いいねを取り消す'
    end.to change(goal.likes, :count).by(1)

    visit goal_path(goal) # リロード

    # 現在のユーザーのプロフィールページに遷移
    visit user_path(user)
    expect(page).to have_content "@#{user.username}"
    expect(page).to have_content '投稿がありません'
    find('#like').click
    expect(page).to have_content 'いいね件数：1'

    # 投稿のいいねを解除する
    visit goal_path(goal)
    expect(page).to have_content 'テスト タイトル'

    expect do
      click_link 'いいねを取り消す'
      expect(page).to have_content 'いいね件数：0'
      expect(page).to have_link 'いいね'
    end.to change(goal.likes, :count).by(-1)

    visit goal_path(goal) # リロード

    # 現在のユーザーのプロフィールページに遷移
    visit user_path(user)
    expect(page).to have_content "@#{user.username}"
    expect(page).to have_content '投稿がありません'
    find('#like').click
    expect(page).to have_content '"いいね！" した投稿がありません'
  end
end