require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  it 'ユーザーの目標にいいねすると対象ユーザーに通知が届く', js: true do
    # 「相手のusernameさんがあなたの投稿にいいねしました」という通知が届く

    # いいねは複数回通知されない（3回いいねしても、通知は1回のみ）
  end

  it 'ユーザーの目標にコメントすると対象ユーザーに通知が届く', js: true do
    user1 = FactoryBot.create(:user, :with_goals, goals_count: 1, email: 'bob@bob.com')
    user2 = FactoryBot.create(:user, email: 'alice@alice.com', password: '123456')
    user1.confirm
    user2.confirm

    goal = user1.goals.first

    # 未ログイン状態ではコメントのフォームが表示されないこと
    visit goal_path(goal)
    find('#comment').click
    expect(page).to_not have_content 'コメントする'

    # ログインする
    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    fill_in 'ユーザーネーム/メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    visit goal_path(goal)
    expect(page).to have_content 'Test Title'

    # ログイン状態ならコメントボタンが表示されること
    expect(page).to have_content 'コメント'

    # コメントする
    expect do
      find('#comment').click
      fill_in 'comment_content', with: 'テスト コメント1'
      click_button 'コメントする'
      expect(page).to have_content 'テスト コメント1'
      expect(page).to have_content 'コメント件数：1'

      find('#comment').click
      fill_in 'comment_content', with: 'テスト コメント2'
      click_button 'コメントする'
      expect(page).to have_content 'テスト コメント2'
      expect(page).to have_content 'コメント件数：2'

      find('#comment').click
      fill_in 'comment_content', with: 'テスト コメント3'
      click_button 'コメントする'
      expect(page).to have_content 'テスト コメント3'
      expect(page).to have_content 'コメント件数：3'
    end.to change(goal.comments, :count).by(3)

    # ログアウト
    visit user_path(user2)
    expect(page).to have_button 'ログアウト'
    click_button 'ログアウト'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ログアウトしました。'

    # コメントされたユーザーでログインする（コメントは複数回通知される）
    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    fill_in 'ユーザーネーム/メールアドレス', with: "bob@bob.com"
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    visit goal_path(goal)
    expect(page).to have_content 'Test Title'

    # 通知画面に移動する
    visit notifications_path
    expect(page).to have_content "#{user2.username} さんが あなたの投稿 にコメントしました"
    expect(page).to have_content "テスト コメント1"
    expect(page).to have_content "テスト コメント2"
    expect(page).to have_content "テスト コメント3"
  end

  it 'ユーザーをフォローすると対象ユーザーに通知が届く', js: true do
    # 「相手のusernameさんがあなたをフォローしました」という通知が届く

    # フォローは複数回通知されない（3回フォローしても、通知は1回のみ）
  end
end