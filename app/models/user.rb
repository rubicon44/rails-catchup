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
  # フォロー機能
  ## 自分がフォローしているユーザーとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  ## 自分がフォローされるユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy, inverse_of: 'visitor'
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # チャット機能
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # いいね判定用メソッド
  def already_liked?(goal)
    self.likes.exists?(goal_id: goal.id)
  end

  # フォロー判定用メソッド
  def already_followed?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # フォロー通知用メソッド
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
