class MessagesController < ApplicationController


  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end

    @visited_id = params[:id]
    @messages = @room.messages
    @message = Message.new(room_id: @room.id)
  end


  def create
    create_message_params = message_params.slice(:message, :room_id)
    @message = current_user.messages.new(create_message_params)
    visited_id = message_params[:visited_id]
    @message.save
    @message.create_notification_message!(current_user, @message.id, visited_id)
  end


  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def message_params
    params.require(:message,).permit(:message, :room_id, :visited_id)
  end

end
