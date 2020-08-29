class Goal < ApplicationRecord
  # user機能
  belongs_to :user, optional: true
  # コメント機能
  has_many :comments, dependent: :destroy
  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # いいね機能用メソッド
  def like(user)
    likes.create(user_id: user.id)
  end
    
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
    
  def like?(user)
    liked_users.include?(user)
  end
end
