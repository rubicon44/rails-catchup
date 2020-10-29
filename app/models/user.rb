class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 目標機能
  has_many :goals, dependent: :destroy
  # コメント機能
  has_many :comments, dependent: :destroy
  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :like_goals, through: :likes, source: :goal
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # いいね判定用メソッド
  def already_liked?(goal)
    self.likes.exists?(goal_id: goal.id)
  end
end
