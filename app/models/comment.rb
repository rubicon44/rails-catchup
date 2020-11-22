class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :goal
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :goal_id, presence: true
  validates :content, presence: true, length: { maximum: 280}
end
