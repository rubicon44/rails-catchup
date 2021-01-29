class User < ApplicationRecord
  attr_accessor :login
  attr_accessor :current_password
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, authentication_keys: [:login]

  has_many :goals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_goals, through: :likes, source: :goal

  ## 自分がフォローしているユーザーとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  ## 自分をフォローしているユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy, inverse_of: 'visitor'
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :username, presence: true, namespace: true, uniqueness: true, length: { in: 4..20 }, format: { with: /\A[a-z0-9_]+\z/ }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, on: :create
  validates :profile, length: { maximum: 140 }

  def to_param
    username
  end

  # usernameとemailのどちらでもログイン可能
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  # いいね判定
  def already_liked?(goal)
    self.likes.exists?(goal_id: goal.id)
  end

  # いいね
  def like(goal)
    likes.create(goal_id: goal.id)
  end

  # いいね解除
  def unlike(goal)
    likes.find_by(goal_id: goal.id).destroy
  end

  # フォロー判定
  def already_followed?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # フォロー
  def follow(user)
    active_relationships.create(follower_id: user.id)
  end

  # フォロー解除
  def unfollow(user)
    active_relationships.find_by(follower_id: user.id).destroy
  end

  # フォロー通知
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
