class GoalsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])

    # 目標詳細画面でコメント機能を使用するため。
    @comments = @goal.comments
    @comment = @goal.comments.build
    # @comment = current_user.comments.new 
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
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
    params.require(:goal).permit(:name, :description)
  end
end
