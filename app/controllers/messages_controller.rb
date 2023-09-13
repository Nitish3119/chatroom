class MessagesController < ApplicationController
  before_action :require_user 

   def create
    room_id = params[:room_id]
    message = Message.create(body: params[:body], room_id: room_id, user_id: current_user.id )

    ActionCable.server.broadcast("chatroom_channel_#{room_id}", { mod_message: message_render(message) })
  end

  private 

  def message_render(message)
    render(partial: 'message', locals: { message: message})
  end

end