# require 'rails_helper'

# RSpec.describe 'SignUp', type: :system do
#   before do
#     ActionMailer::Base.deliveries.clear
#   end

#   def extract_url(mail)
#     body = mail.body.encoded
#     body[/http[^"]+/]
#   end

#   it 'ユーザーを作成したあと、確認メールからアカウントを有効化してログインする' do
#     visit root_path

#     click_link '新規登録'
#     expect(current_path).to eq new_user_registration_path
#     expect(page).to have_content "小文字の半角英数字と'_'(アンダーバー)のみ"

#     # 登録に失敗する場合
#     fill_in '名前', with: ''
#     fill_in 'ユーザーネーム', with: 'users' # 既存のルーティング("/users")と重複するユーザーネーム
#     fill_in 'メールアドレス', with: 'sample@invalid'
#     fill_in 'パスワード', with: '123456'
#     fill_in 'パスワードの再入力', with: 'abcdef'

#     click_button 'アカウントを作成する'
#     expect(page).to have_content '名前が未入力です'
#     expect(page).to have_content 'ユーザーネームは既に使用されています'
#     expect(page).to have_content 'メールアドレスは有効でありません'
#     expect(page).to have_content 'パスワードの再入力が一致しません'

#     # 登録に成功する場合
#     fill_in '名前', with: 'Alice'
#     fill_in 'ユーザーネーム', with: 'alice'
#     fill_in 'メールアドレス', with: 'alice@example.com'
#     fill_in 'パスワード', with: '123456'
#     fill_in 'パスワードの再入力', with: '123456'

#     expect do
#       click_button 'アカウントを作成する'
#     end.to change(User, :count).by(1) &
#            change { ActionMailer::Base.deliveries.size }.by(1)

#     expect(current_path).to eq confirm_email_path
#     expect(page).to have_content 'メールを送信しました'

#     mail = ActionMailer::Base.deliveries.last
#     confirmation_url = extract_url(mail)

#     aggregate_failures do
#       expect(mail.to).to eq ['alice@example.com']
#       expect(mail.from).to eq ['info@mewblr.com']
#       expect(mail.subject).to eq 'アカウントの登録確認'
#       expect(mail.body).to match 'Alice'
#       expect(mail.body).to match '(@alice)'
#       expect(mail.body).to have_link 'メールアドレスを認証', href: confirmation_url
#     end

#     visit confirmation_url
#     expect(current_path).to eq new_user_session_path
#     expect(page).to have_content 'おめでとうございます。メールアドレスは正常に承認されました。'

#     fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
#     fill_in 'パスワード', with: '123456'
#     click_button 'ログインする'
#     expect(page).to have_content 'フィード'
#   end

#   it '再送信された確認メールからアカウントを有効化してログインする' do
#     FactoryBot.create(:user, :unconfirmed,
#                       username: 'alice',
#                       email: 'alice@example.com',
#                       password: '123456')

#     visit new_user_session_path
#     expect(page).to have_content 'ログイン状態を保持'

#     fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
#     fill_in 'パスワード', with: '123456'
#     click_button 'ログインする'
#     expect(page).to have_content 'アカウントが有効化されていません。'

#     click_link 'こちら'
#     expect(current_path).to eq new_user_confirmation_path
#     expect(page).to have_content '確認メールを再発行致します。'

#     fill_in 'メールアドレス', with: 'alice@example.com'
#     expect do
#       click_button '再発行する'
#     end.to change { ActionMailer::Base.deliveries.size }.by(1)
#     expect(page).to have_content '確認メールを再発行致しました'

#     mail = ActionMailer::Base.deliveries.last
#     confirmation_url = extract_url(mail)

#     visit confirmation_url
#     expect(current_path).to eq new_user_session_path
#     expect(page).to have_content 'おめでとうございます。メールアドレスは正常に承認されました。'

#     fill_in 'ユーザーネーム/メールアドレス', with: 'alice'
#     fill_in 'パスワード', with: '123456'
#     click_button 'ログインする'
#     expect(page).to have_content 'フィード'
#   end
# end
