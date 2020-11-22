class GoalsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search]

  def index
    @search = Goal.ransack(params[:q])
    @goals = @search.result
  end

  def show
    @goal = Goal.find(params[:id])
    @comments = @goal.comments
    @comment = @goal.comments.build
    @like = Like.new
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.save

    redirect_to root_url
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to @goal
    else
      render 'edit'
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    redirect_to goals_path
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :description, :status)
  end
end
