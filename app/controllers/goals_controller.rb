class GoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])

    # コメント機能に使用
    @comments = @goal.comments
    @comment = @goal.comments.build

    # いいね機能に使用
    @like = Like.new
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    # 下記記述を追記することによって、goalを作成した時に同時に、作成した人のidも一緒に保存される。
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
    params.require(:goal).permit(:name, :description)
  end
end
