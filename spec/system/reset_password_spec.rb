# require 'rails_helper'

# RSpec.describe 'ResetPassword', type: :system do
#   before do
#     ActionMailer::Base.deliveries.clear
#   end

#   def extract_url(mail)
#     body = mail.body.encoded
#     body[/http[^"]+/]
#   end

#   it '非ログイン状態から、ユーザーのパスワードを再設定する' do
#     user = FactoryBot.create(:user,
#                              email: 'alice@example.com',
#                              password: 'OldPassword')

#     visit root_path

#     click_link 'ログイン'
#     click_link 'パスワードをお忘れの方はこちら'
#     expect(current_path).to eq new_user_password_path

#     fill_in 'メールアドレス', with: 'alice@example.com'

#     expect do
#       click_button '再設定用のメールを送信する'
#     end.to change { ActionMailer::Base.deliveries.size }.by(1)

#     expect(current_path).to eq new_user_session_path
#     expect(page).to have_content 'パスワード再設定の為のメールをお送りしました。確認をお願いします。（メールの到着には数分かかる可能性があります）'

#     mail = ActionMailer::Base.deliveries.last
#     reset_password_url = extract_url(mail)

#     aggregate_failures do
#       expect(mail.from).to eq ['info@railsCatchup.com']
#       expect(mail.subject).to eq 'パスワードの再設定'
#       expect(mail.to).to eq ['alice@example.com']
#       expect(mail.body).to have_link 'パスワード変更', href: reset_password_url
#     end

#     visit reset_password_url
#     expect(page).to have_content '新しいパスワードを再入力'

#     fill_in '新しいパスワード', with: 'NewPassword'
#     fill_in '新しいパスワードを再入力', with: 'NewPassword'
#     click_button '変更を確定する'
#     # expect(page).to have_content 'ログインしました。'

#     # expect(user.reload.valid_password?('NewPassword')).to eq true
#   end
# end