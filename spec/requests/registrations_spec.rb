require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /new_user_registration' do
    context '認証済みのユーザーの場合' do
      before do
        user = FactoryBot.create(:user)
        sign_in user
      end

      it 'タスク一覧ページが表示されること' do
        get goals_path
        expect(response).to have_http_status '302'
      end
    end

    context '未ログイン状態のとき' do
      it '正常にレスポンスを返すこと' do
        get new_user_registration_path
        expect(response).to have_http_status '200'
      end
    end
  end
end
