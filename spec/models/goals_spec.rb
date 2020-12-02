require 'rails_helper'
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }

  it '有効なファクトリを持つこと' do
    expect(post).to be_valid
  end

  it 'ユーザー、画像、URLトークンがあれば有効な状態であること' do
    user = FactoryBot.create(:user)
    post = Post.new(
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')),
      user: user,
      url_token: SecureRandom.urlsafe_base64
    )
    expect(post).to be_valid
  end

  describe '存在性の検証' do
    it '画像がなければ無効な状態であること' do
      post.image = nil
      post.valid?
      expect(post.errors).to be_added(:image, :blank)
    end

    it 'ユーザーがなければ無効な状態であること' do
      post.user = nil
      post.valid?
      expect(post.errors).to be_added(:user, :blank)
    end

    it 'URLトークンがなければ無効な状態であること' do
      post.url_token = nil
      post.valid?
      expect(post.errors).to be_added(:url_token, :blank)
    end
  end

  describe '一意性の検証' do
    it '重複したURLトークンなら無効な状態であること' do
      url_token = post.url_token

      duplicate_post = FactoryBot.create(:post)
      duplicate_post.url_token = url_token
      duplicate_post.valid?
      expect(duplicate_post.errors).to be_added(:url_token, :taken, value: url_token)
    end
  end

  describe '文字数の検証' do
    it 'キャプションが240文字以内なら有効であること' do
      post.caption = 'a' * 240
      expect(post).to be_valid
    end

    it 'キャプションが240文字を越えるなら無効であること' do
      post.caption = 'a' * 241
      post.valid?
      expect(post.errors).to be_added(:caption, :too_long, count: 240)
    end
  end

  describe 'メソッド' do
    it '投稿をいいね/いいね解除できること' do
      alice = FactoryBot.create(:user)
      bob = FactoryBot.create(:user, :with_posts, posts_count: 1)
      expect(bob.posts.first.like?(alice)).to eq false
      bob.posts.first.like(alice)
      expect(bob.posts.first.like?(alice)).to eq true
      bob.posts.last.unlike(alice)
      expect(bob.posts.first.like?(alice)).to eq false
    end
  end

  describe 'その他' do
    it '編集しても、URLトークンが変わらないこと' do
      url_token = post.url_token
      post.caption = "I don't like it."
      post.save
      expect(post.url_token).to eq url_token
    end

    it '新しい順に並んでいること' do
      most_recent_post = FactoryBot.create(:post, created_at: Time.zone.now)
      FactoryBot.create(:post, created_at: 10.minutes.ago)
      FactoryBot.create(:post, created_at: 3.years.ago)
      FactoryBot.create(:post, created_at: 2.hours.ago)

      expect(most_recent_post).to eq Post.first
    end

    it '削除すると、関連するコメントも削除されること' do
      post = FactoryBot.create(:post, :with_comments, comments_count: 1)

      expect do
        post.destroy
      end.to change(Comment, :count).by(-1)
    end

    it '削除すると、関連するいいねも削除されること' do
      post = FactoryBot.create(:post, :with_likes, likes_count: 1)

      expect do
        post.destroy
      end.to change(Like, :count).by(-1)
    end
  end
end
