require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  it '既存の投稿にコメントをして、削除する', js: true do
    goal = FactoryBot.create(:goal, name: 'テスト タイトル')

    # 未ログイン状態ではコメントのフォームが表示されないこと
    visit goal_path(goal)
    expect(page).to_not have_content 'コメント一覧'

    # ログインする
    user = FactoryBot.create(:user, email: 'alice@alice.com', password: '123456')
    visit root_path

    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
    # expect(page).to have_content 'ログイン状態を保持'

    fill_in 'メールアドレス', with: 'alice@alice.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content 'タスク一覧'
    # expect(page).to have_content 'フィード'

    visit goal_path(goal)
    expect(page).to have_content 'テスト タイトル'

    # ログイン状態ならコメントのフォームが表示されること
    expect(page).to have_content 'コメント一覧'

    # todo: 下記jQuery実装時のテスト（Modelのvalidateにより、240時以上のコメントはシステム上登録されないが、やはりjQuery等が欲しい。）
    # # 制限内の文字数を入力した場合
    # fill_in 'コメントを入力...', with: 'a' * 240
    # expect(page).to_not have_content '文字数制限を超えています'
    # expect(page).to have_css '#comment_btn'

    # コメントする
    expect do
      fill_in 'comment_content', with: 'テスト コメント1'
      click_button 'コメントする'
      expect(page).to have_content 'テスト コメント1'
      expect(page).to have_content 'コメント件数：1'

      fill_in 'comment_content', with: 'テスト コメント2'
      click_button 'コメントする'
      expect(page).to have_content 'テスト コメント2'
      expect(page).to have_content 'コメント件数：2'

      fill_in 'comment_content', with: 'テスト コメント3'
      click_button 'コメントする'
      expect(page).to have_content 'テスト コメント3'
      expect(page).to have_content 'コメント件数：3'
    end.to change(goal.comments, :count).by(3)

    # コメントを削除する
    comment = goal.comments.find_by!(content: 'テスト コメント3')
    expect(page).to have_link "削除", href: "/goals/#{goal.id}/comments/#{comment.id}"
    click_link "削除", href: "/goals/#{goal.id}/comments/#{comment.id}"
    expect(page.driver.browser.switch_to.alert.text).to eq "コメントを削除しますか？"

    expect do
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'コメント件数：2'
      expect(page).to_not have_content 'テスト コメント3'
      expect(page).to have_content 'テスト コメント2'
      expect(page).to have_content 'テスト コメント1'
    end.to change(Comment, :count).by(-1)
  end
end
