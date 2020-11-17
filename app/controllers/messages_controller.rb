class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, chat_room_id: params[:message][:chat_room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :chat_room_id).merge(user_id: current_user.id))
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
　　redirect_to "/chat_rooms/#{@message.chat_room_id}"
  end
end
