class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.where(id: params[:id])
  end

  # フォロー機能
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
end
