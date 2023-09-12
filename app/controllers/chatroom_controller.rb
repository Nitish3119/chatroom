class ChatroomController < ApplicationController
  before_action :require_user
  def index
    @rooms = current_user.room
    @message = Message.new
    @messages = Message.custom_display
  end
end
