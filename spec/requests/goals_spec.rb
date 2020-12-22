require 'rails_helper'

RSpec.describe 'Goals', type: :request do
  # describe '#new' do
  #   context '未ログイン状態のとき' do
  #     it 'ログインページにリダイレクトされること' do
  #       get new_goal_path
  #       expect(response).to have_http_status 302
  #       expect(response).to redirect_to '/users/sign_in'
  #     end
  #   end
  # end

  # describe '#create' do
  #   context '未ログイン状態のとき' do
  #     it 'ログインページにリダイレクトされること' do
  #       goal_params = FactoryBot.attributes_for(:goal)
  #       post goals_path, params: { goal: goal_params }
  #       expect(response).to have_http_status 302
  #       expect(response).to redirect_to '/users/sign_in'
  #     end
  #   end
  # end

  # describe '#edit' do
  #   context '未ログイン状態のとき' do
  #     it 'ログインページにリダイレクトされること' do
  #       goal = FactoryBot.create(:goal)
  #       get edit_goal_path(goal)
  #       expect(response).to have_http_status 302
  #       expect(response).to redirect_to '/users/sign_in'
  #     end
  #   end
  # end

  # 下記コメントアウト（現在Token認証を実装していないため、このテストは実行できない。）
  describe '#update' do
    context '認可されていないユーザーとして' do
      it '投稿を更新できないこと' do
        goal = FactoryBot.create(:goal, name: 'Same old name.', description: 'Some old description')

        user = FactoryBot.create(:user)
        sign_in user

        goal_params = FactoryBot.attributes_for(:goal, name: 'New Name.', description: 'New description')
        patch goal_path(goal), params: { goal: goal_params }
        expect(goal.reload.name).to eq 'Same old name.'
        expect(goal.reload.description).to eq 'Same old description.'
        expect(response).to redirect_to '/'
      end
    end

    # context '未ログイン状態のとき' do
    #   it 'ログインページにリダイレクトされること' do
    #     goal = FactoryBot.create(:goal)

    #     goal_params = FactoryBot.attributes_for(:goal, caption: 'I like it.')
    #     patch goal_path(goal), params: { goal: goal_params }
    #     expect(response).to have_http_status 302
    #     expect(response).to redirect_to '/users/sign_in'
    #   end
    # end
  end

  # 下記コメントアウト（現在Token認証を実装していないため、このテストは実行できない。）
  describe '#destroy' do
    before do
      @goal = FactoryBot.create(:goal)
    end

    context '認可されていないユーザーとして' do
      it '投稿を削除できないこと' do
        user = FactoryBot.create(:user)
        sign_in user
        expect do
          delete goal_path(@goal)
        end.to_not change(Goal, :count)
      end
    end

    # context '未ログイン状態のとき' do
    #   it 'ログインページにリダイレクトされること' do
    #     delete goal_path(@goal)
    #     expect(response).to have_http_status 302
    #     expect(response).to redirect_to '/users/sign_in'
    #   end
    # end
  end
end
