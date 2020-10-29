class Goal < ApplicationRecord
  # user機能
  belongs_to :user, optional: true
  # コメント機能
  has_many :comments, dependent: :destroy
  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  # 通知機能
  has_many :notifications, dependent: :destroy
end
