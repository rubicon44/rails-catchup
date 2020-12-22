require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /confirm_email' do
    context '認証済みのユーザーの場合' do
      before do
        user = FactoryBot.create(:user)
        sign_in user
      end

      it 'トップページにリダイレクトされること' do
        get confirm_email_path
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/'
      end
    end

    context '未ログイン状態のとき' do
      it '正常にレスポンスを返すこと' do
        get confirm_email_path
        expect(response).to have_http_status '200'
      end
    end
  end
end
