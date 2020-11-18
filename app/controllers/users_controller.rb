class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.where(id: params[:id])

    # プロフィール用
    @goals = @user.goals.page(params[:page]).per(24)
    @likes = @user.like_goals.page(params[:page]).per(24)

    # チャット機能用
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.chat_room_id == u.chat_room_id
            @isRoom = true
            @roomId = cu.chat_room_id
          end
        end
      end
      unless @isRoom
        @room = ChatRoom.new
        @entry = Entry.new
      end
    end
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
