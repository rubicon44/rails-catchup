require 'rails_helper'

RSpec.describe 'Goals', type: :system, js: true do
  it '新規投稿したあと、その投稿を編集して最後に削除する' do
    user = FactoryBot.create(:user, email: 'alice@alice.com', password: '123456')

    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'
    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'

    # 新規の投稿をする
    click_link '目標追加'
    expect(current_path).to eq new_goal_path
    fill_in '題名', with: 'テスト タイトル'
    fill_in '内容', with: 'テスト コンテント'
    expect do
      click_button '登録'
    end.to change(Goal, :count).by(1)

    # expect(current_path).to eq user_path(user)
    # expect(page).to have_content '投稿が送信されました'

    goal = Goal.first
    expect(goal.name).to eq 'テスト タイトル'
    expect(goal.description).to eq 'テスト コンテント'
    expect(page).to have_link "Show", href: "/goals/#{goal.id}"

    click_link "Show", href: "/goals/#{goal.id}"
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
    # expect(page).to have_content '投稿が更新されました'
    expect(page).to_not have_content 'テスト タイトル'
    expect(page).to_not have_content 'テスト コンテント'
    expect(page).to have_content "タイトル"
    expect(page).to have_content "コンテント"

    # 投稿を削除する
    click_link '削除'
    expect(page.driver.browser.switch_to.alert.text).to eq "投稿を削除しますか？"

    expect do
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '投稿は正常に削除されました'
    end.to change(Goal, :count).by(-1)

    expect(current_path).to eq goals_path
    expect(page).to_not have_link 'Show', href: "/goals/#{goal.id}"
  end

  # it 'フィードページから正しく投稿を削除できること' do
  #   user = FactoryBot.create(:user, username: 'alice')
  #   goal_foo = FactoryBot.create(:goal, caption: 'foo', user: user)
  #   goal_bar = FactoryBot.create(:goal, caption: 'bar', user: user)
  #   goal_baz = FactoryBot.create(:goal, caption: 'baz', user: user)

  #   visit root_path

  #   click_link 'ログイン'
  #   expect(current_path).to eq new_user_session_path
  #   expect(page).to have_content 'ログイン状態を保持'

  #   fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
  #   fill_in 'パスワード', with: '123456'
  #   click_button 'ログインする'
  #   expect(page).to have_content 'フィード'

  #   expect(page).to have_content 'foo'
  #   expect(page).to have_content 'bar'
  #   expect(page).to have_content 'baz'

  #   find("#goal-dropdown-#{goal_foo.id}").click
  #   expect(page).to have_content '投稿を削除'

  #   find("#goal-dropdown-delete-#{goal_foo.id}").click
  #   expect(page).to have_content '投稿を削除しますか？'

  #   expect do
  #     find("a[href='#{goal_path(goal_foo)}']").click
  #   end.to change(Goal, :count).by(-1)
  #   expect(current_path).to eq user_path(user)
  #   expect(page).to have_content '投稿は正常に削除されました'

  #   visit root_path

  #   expect(page).to_not have_content 'foo'
  #   expect(page).to have_content 'bar'
  #   expect(page).to have_content 'baz'
  # end
end