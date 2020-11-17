class ChatRoomsController < ApplicationController
  def index
  end

  def create
    @room = ChatRoom.create
    @entry1 = Entry.create(chat_room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :chat_room_id).merge(chat_room_id: @room.id))
    redirect_to "/chat_rooms/#{@room.id}"
  end

  def show
    @room = ChatRoom.find(params[:id])
    if Entry.where(user_id: current_user.id,chat_room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
