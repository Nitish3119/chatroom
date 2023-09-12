class MessagesController < ApplicationController
  before_action :require_user 

  def create
    message = current_user.messages.build(message_params)
    room_id = message_params[:room_id]

    if message.save
      ActionCable.server.broadcast("chatroom_channel_#{room_id}", { mod_message: message_render(message) })
    else
      # Handle validation errors or failed message creation
      flash[:error] = "Unable to create the message. Please try again."
    end
  end


  private 

  def message_params
    params.require(:message).permit(:body, :room_id)
  end

  def message_render(message)
    render(partial: 'message', locals: { message: message})
  end

end