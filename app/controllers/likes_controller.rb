class LikesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @goal = Goal.find(params[:goal_id])
  end

  def create
    # いいね
    @goal = Goal.find(params[:goal_id])
    current_user.like(@goal)
    redirect_back(fallback_location: root_path)

    # いいね通知
    @goal = Goal.find(params[:goal_id])
    @goal.create_notification_like!(current_user)
  end

  def destroy
    # いいね解除
    @goal = Goal.find(params[:goal_id])
    current_user.unlike(@goal)
    redirect_back(fallback_location: root_path)
  end
end
