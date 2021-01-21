require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it '有効なファクトリを持つこと' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it '名前、ユーザーネーム、メールアドレス、パスワードがあれば有効な状態であること' do
    user = User.new(
      username: 'sample',
      email: 'sample@example.com',
      password: '123456'
    )
    expect(user).to be_valid
  end

  describe '存在性の検証' do
    it 'ユーザーネームがなければ無効な状態であること' do
      @user.username = nil
      @user.valid?
      expect(@user.errors).to be_added(:username, :blank)
    end

    it 'メールアドレスがなければ無効な状態であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors).to be_added(:email, :blank)
    end

    it 'パスワードがなければ無効な状態であること' do
      @user.password = @user.password_confirmation = ' ' * 6
      @user.valid?
      expect(@user.errors).to be_added(:password, :blank)
    end
  end

  describe '一意性の検証' do
    it '重複したユーザーネームなら無効な状態であること' do
      user = FactoryBot.create(:user, username: 'sample')
      duplicate_user = FactoryBot.build(:user, username: 'sample')
      duplicate_user.valid?
      expect(duplicate_user.errors).to be_added(:username, :taken, value: 'sample')
    end

    it '既存のルーティングと重複したユーザーネームなら無効であること' do
      aggregate_failures do
        # expect(FactoryBot.build(:user, username: 'confirm_email')).to_not be_valid
        expect(FactoryBot.build(:user, username: 'users')).to_not be_valid
        # expect(FactoryBot.build(:user, username: 'relationships')).to_not be_valid
        expect(FactoryBot.build(:user, username: 'goals')).to_not be_valid
        # expect(FactoryBot.build(:user, username: 'likes')).to_not be_valid
        expect(FactoryBot.build(:user, username: 'rails')).to_not be_valid
      end
    end

    it '重複したメールアドレスなら無効な状態であること' do
      user = FactoryBot.create(:user, email: 'sample@example.com')
      duplicate_user = FactoryBot.build(:user, email: 'sample@example.com')
      duplicate_user.valid?
      expect(duplicate_user.errors).to be_added(:email, :taken, value: 'sample@example.com')
    end

    it 'メールアドレスは大文字小文字を区別せず扱うこと' do
      user = FactoryBot.create(:user, email: 'sample@example.com')
      duplicate_user = FactoryBot.build(:user, email: 'SAMPLE@EXAMPLE.COM')
      duplicate_user.valid?
      expect(duplicate_user.errors).to be_added(:email, :taken, value: 'sample@example.com')
    end
  end

  describe '文字数の検証' do
    it 'ユーザーネームが4文字未満なら無効であること' do
      @user.username = 'a' * 3
      @user.valid?
      expect(@user.errors).to be_added(:username, :too_short, count: 4)
    end

    it 'ユーザーネームが4~20文字の範囲なら有効であること' do
      @user.username = 'a' * 10
      expect(@user).to be_valid
    end

    it 'ユーザーネームが20文字を越えるなら無効であること' do
      @user.username = 'a' * 21
      @user.valid?
      expect(@user.errors).to be_added(:username, :too_long, count: 20)
    end

    it 'メールアドレスが255文字以内なら有効であること' do
      @user.email = 'a' * 243 + '@example.com'
      expect(@user).to be_valid
    end

    it 'メールアドレスが255文字を越えるなら無効であること' do
      @user.email = 'a' * 244 + '@example.com'
      @user.valid?
      expect(@user.errors).to be_added(:email, :too_long, count: 255)
    end

    it 'パスワードが6文字未満なら無効であること' do
      @user.password = @user.password_confirmation = 'a' * 5
      @user.valid?
      expect(@user.errors).to be_added(:password, :too_short, count: 6)
    end

    it 'パスワードが6文字以上なら有効であること' do
      @user.password = @user.password_confirmation = 'a' * 6
      expect(@user).to be_valid
    end

    it '自己紹介が140文字以内なら有効であること' do
      @user.profile = 'a' * 140
      expect(@user).to be_valid
    end

    it '自己紹介が140文字を越えるなら無効であること' do
      @user.profile = 'a' * 141
      @user.valid?
      expect(@user.errors).to be_added(:profile, :too_long, count: 140)
    end
  end

  describe 'フォーマットの検証' do
    it 'ユーザーネームが正当なフォーマットなら有効であること' do
      valid_usernames = %w[aaaaa aaaa_ aaaa0]
      valid_usernames.each do |valid_username|
        @user.username = valid_username
        expect(@user).to be_valid
      end
    end

    it 'ユーザーネームが不正なフォーマットなら無効であること' do
      invalid_usernames = %w[aaaa- aaaa+ aaaa! aaaa? aaaa. aaaa* aaaa@ aaaa$
                             aaaa% aaaa^ aaaa= aaaa: aaaa; aaaa, aaaa~ aaaa` あああああ`]
      invalid_usernames.each do |invalid_username|
        @user.username = invalid_username
        @user.valid?
        expect(@user.errors).to be_added(:username, :invalid, value: invalid_username)
      end
    end

    it 'メールアドレスが正当なフォーマットなら有効であること' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it 'メールアドレスが不正なフォーマットなら無効であること' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.valid?
        expect(@user.errors).to be_added(:email, :invalid, value: invalid_address)
      end
    end
  end

  # describe 'メソッド' do
  #   it 'ユーザーをフォロー/フォロー解除できること' do
  #     alice = FactoryBot.create(:user)
  #     bob = FactoryBot.create(:user)
  #     expect(alice.already_followed?(bob)).to eq false
  #     alice.follow(bob)
  #     expect(alice.already_followed?(bob)).to eq true
  #     alice.unfollow(bob)
  #     expect(alice.already_followed?(bob)).to eq false
  #   end

  #   it 'フィードが正しい投稿のコレクションを保持していること' do
  #     alice = FactoryBot.create(:user, :with_goals, goals_count: 2)
  #     bob = FactoryBot.create(:user, :with_goals, goals_count: 2)
  #     carol = FactoryBot.create(:user, :with_goals, goals_count: 2)

  #     alice.follow(bob)

  #     # フォローしているユーザーの投稿を確認
  #     bob.goals.each do |goal_following|
  #       expect(alice.feed).to include(goal_following)
  #     end
  #     # 自分自身の投稿を確認
  #     alice.goals.each do |goal_self|
  #       expect(alice.feed).to include(goal_self)
  #     end
  #     # フォローしていないユーザーの投稿を確認
  #     carol.goals.each do |goal_unfollowed|
  #       expect(alice.feed).to_not include(goal_unfollowed)
  #     end
  #   end
  # end

  # describe 'その他' do
  #   # it 'メールアドレスは全て小文字で保存されること' do
  #   #   @user.email = 'Foo@ExAMPle.CoM'
  #   #   @user.save!
  #   #   expect(@user.reload.email).to eq 'foo@example.com'
  #   # end

  #   # it '削除すると、関連する投稿も削除されること' do
  #   #   user = FactoryBot.create(:user)
  #   #   goal = FactoryBot.create(:goal, user: user)

  #   #   expect do
  #   #     user.destroy
  #   #   end.to change(Goal, :count).by(-1)
  #   # end

  #   it '削除すると、フォロー中のユーザーとの関係も削除されること' do
  #     user = FactoryBot.create(:user)
  #     following_user = FactoryBot.create(:user)
  #     user.follow(following_user)

  #     expect do
  #       user.destroy
  #     end.to change(following_user.followers, :count).by(-1)
  #   end

  #   it '削除すると、フォロワーのユーザーとの関係も削除されること' do
  #     user = FactoryBot.create(:user)
  #     follower_user = FactoryBot.create(:user)
  #     follower_user.follow(user)

  #     expect do
  #       user.destroy
  #     end.to change(follower_user.following, :count).by(-1)
  #   end
  # end
end
