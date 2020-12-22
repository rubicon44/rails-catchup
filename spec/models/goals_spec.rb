require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:goal) { FactoryBot.create(:goal) }

  # it '有効なファクトリを持つこと' do
  #   expect(goal).to be_valid
  # end

  # it 'ユーザーがあれば有効な状態であること' do
  #   user = FactoryBot.create(:user)
  #   goal = Goal.new(
  #     user: user,
  #   )
  #   expect(goal).to be_valid
  # end

  describe '存在性の検証' do
    it 'ユーザーがなければ無効な状態であること' do
      goal.user = nil
      goal.valid?
      expect(goal.errors).to be_added(:user, :blank)
    end
  end

  # describe '文字数の検証' do
  #   it 'ディスクリプションが140文字以内なら有効であること' do
  #     goal.description = 'a' * 240
  #     expect(goal).to be_valid
  #   end

  #   it 'ディスクリプションが140文字を越えるなら無効であること' do
  #     goal.description = 'a' * 241
  #     goal.valid?
  #     expect(goal.errors).to be_added(:description, :too_long, count: 240)
  #   end
  # end

  describe 'メソッド' do
    it '投稿をいいね/いいね解除できること' do
      alice = FactoryBot.create(:user)
      bob = FactoryBot.create(:user, :with_goals, goals_count: 1)
      expect(bob.goals.first.like?(alice)).to eq false
      bob.goals.first.like(alice)
      expect(bob.goals.first.like?(alice)).to eq true
      bob.goals.last.unlike(alice)
      expect(bob.goals.first.like?(alice)).to eq false
    end
  end

  # describe 'その他' do
  #   it '新しい順に並んでいること' do
  #     most_recent_goal = FactoryBot.create(:goal, created_at: Time.zone.now)
  #     FactoryBot.create(:goal, created_at: 10.minutes.ago)
  #     FactoryBot.create(:goal, created_at: 3.years.ago)
  #     FactoryBot.create(:goal, created_at: 2.hours.ago)

  #     expect(most_recent_goal).to eq Goal.first
  #   end

  #   it '削除すると、関連するコメントも削除されること' do
  #     goal = FactoryBot.create(:goal, :with_comments, comments_count: 1)

  #     expect do
  #       goal.destroy
  #     end.to change(Comment, :count).by(-1)
  #   end

  #   it '削除すると、関連するいいねも削除されること' do
  #     goal = FactoryBot.create(:goal, :with_likes, likes_count: 1)

  #     expect do
  #       goal.destroy
  #     end.to change(Like, :count).by(-1)
  #   end
  # end
end
