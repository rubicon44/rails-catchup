require 'rails_helper'

RSpec.describe 'Goals', type: :system, js: true do
  it '新規投稿したあと、その投稿を編集して最後に削除する' do
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

    # 新規の投稿をする
    find('#goal-addbutton').click
    expect(current_path).to eq new_goal_path
    fill_in '題名', with: 'テスト タイトル'
    fill_in '内容', with: 'テスト コンテント'
    expect do
      click_button '登録'
    end.to change(Goal, :count).by(1)

    expect(current_path).to eq user_path(user)
    expect(page).to have_content '投稿が送信されました。'

    goal = Goal.first
    expect(goal.name).to eq 'テスト タイトル'
    expect(goal.description).to eq 'テスト コンテント'
    find('#goal').click
    expect(current_path).to eq goal_path(goal)
    expect(page).to have_content 'テスト タイトル'
    expect(page).to have_content 'テスト コンテント'

    # 投稿を編集する
    expect(page).to have_link "編集", href: "/goals/#{goal.id}/edit"
    click_link '編集'
    expect(current_path).to eq edit_goal_path(goal)
    expect(page).to have_button '登録'

    fill_in '題名', with: "タイトル"
    fill_in '内容', with: "コンテント"
    click_button '登録'

    expect(current_path).to eq goal_path(goal)
    expect(page).to have_content '投稿が更新されました。'
    expect(page).to_not have_content 'テスト タイトル'
    expect(page).to_not have_content 'テスト コンテント'
    expect(page).to have_content "タイトル"
    expect(page).to have_content "コンテント"

    # 投稿を削除する
    click_link '削除'
    expect(page.driver.browser.switch_to.alert.text).to eq "投稿を削除しますか？"

    expect do
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '投稿は正常に削除されました。'
    end.to change(Goal, :count).by(-1)

    expect(current_path).to eq goals_path
    expect(page).to_not have_content 'タイトル'
    expect(page).to_not have_content 'コンテント'
  end
end