class RelationshipsController < ApplicationController
  protect_from_forgery except: :create
  before_action :authenticate_user!

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_back(fallback_location: root_path)

    # フォロー通知用メソッドの呼び出し
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end
end
