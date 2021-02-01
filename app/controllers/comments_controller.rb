class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # コメント
    @goal = Goal.find(params[:goal_id])
    @comment = @goal.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      # コメント通知
      @goal.create_notification_comment!(current_user, @comment.id)
      flash[:success] = 'コメントしました。'
    else
      flash[:success] = 'コメントできませんでした。'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # コメント解除
    @comment = Comment.find(params[:id]).destroy
    flash[:success] = '投稿へのコメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
