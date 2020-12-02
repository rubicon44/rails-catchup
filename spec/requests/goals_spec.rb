require 'rails_helper'

RSpec.describe 'Goals', type: :request do
  describe '#new' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        get new_post_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        post_params = FactoryBot.attributes_for(:post)
        post posts_path, params: { post: post_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#edit' do
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        post = FactoryBot.create(:post)
        get edit_post_path(post)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#update' do
    context '認可されていないユーザーとして' do
      it '投稿を更新できないこと' do
        post = FactoryBot.create(:post, caption: 'Same old caption.')

        user = FactoryBot.create(:user)
        sign_in user

        post_params = FactoryBot.attributes_for(:post, caption: 'New caption.')
        patch post_path(post), params: { post: post_params }
        expect(post.reload.caption).to eq 'Same old caption.'
        expect(response).to redirect_to '/'
      end
    end

    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        post = FactoryBot.create(:post)

        post_params = FactoryBot.attributes_for(:post, caption: 'I like it.')
        patch post_path(post), params: { post: post_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    before do
      @post = FactoryBot.create(:post)
    end

    context '認可されていないユーザーとして' do
      it '投稿を削除できないこと' do
        user = FactoryBot.create(:user)
        sign_in user
        expect do
          delete post_path(@post)
        end.to_not change(Post, :count)
      end
    end

    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        delete post_path(@post)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
