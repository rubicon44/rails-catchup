class RelationshipsController < ApplicationController
  protect_from_forgery except: :create
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)

    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end
end
