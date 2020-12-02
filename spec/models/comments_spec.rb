require 'rails_helper'

RSpec.describe Comment, type: :model do
  it '内容がなければ無効であること' do
    comment = FactoryBot.create(:comment)
    comment.content = nil
    comment.valid?
    expect(comment.errors).to be_added(:content, :blank)
  end

  it '内容が240文字以内なら有効であること' do
    comment = FactoryBot.create(:comment)
    comment.content = 'a' * 240
    expect(comment).to be_valid
  end

  it '内容が240文字を越えるなら無効であること' do
    comment = FactoryBot.create(:comment)
    comment.content = 'a' * 241
    comment.valid?
    expect(comment.errors).to be_added(:content, :too_long, count: 240)
  end

  it '新しい順に並んでいること' do
    post = FactoryBot.create(:post)
    most_recent_comment = FactoryBot.create(:comment, post: post, created_at: Time.zone.now)
    FactoryBot.create(:comment, post: post, created_at: 10.minutes.ago)
    FactoryBot.create(:comment, post: post, created_at: 3.years.ago)
    FactoryBot.create(:comment, post: post, created_at: 2.hours.ago)

    expect(most_recent_comment).to eq post.comments.first
  end
end
