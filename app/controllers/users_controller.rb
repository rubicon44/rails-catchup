class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search]
  before_action :admin_user,     only: :destroy

  def index
    @search = User.ransack(params[:q])
    @users = @search.result
    @user = User.page(params[:page]).per(24)
  end

  def show
    @user = User.find_by!(username: params[:username])
    @users = User.where(username: params[:username])

    # プロフィール用
    @goals = @user.goals.page(params[:page]).per(24)
    @likes = @user.like_goals.page(params[:page]).per(24)
  end

  def destroy
    User.find_by!(username: params[:username]).destroy
    flash[:success] = 'ユーザーは正常に削除されました。'
    redirect_to users_path
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
