class UserController < ApplicationController
  def new
  end
  def show
    user = User.find_by(id: params[:id])
    @rooms = user.room
    @message = Message.new
    @messages = Message.custom_display
    @public_rooms = Room.except(@rooms).public_rooms
    @private_rooms = Room.except(@rooms).private_rooms
    @requested_ids = user.requests.pluck(:room_id)
  end

  def create
    user =  User.new(username: params[:name], password: params[:password])
    if user.save!
      flash[:success] = "#{params[:name]} , Your account has been successfully created please login to get into account"
      redirect_to login_path
    else
      flash.now[:error] = "There was something wrong with your signup information"
      redirect_to user_new_path
    end
  end

  def join_chat_room
    member = Member.new(user_id: params[:id], room_id: params[:room_id])
    if member.save
      flash[:success] = "You are added to the chat room successfully"
    else
      flash.now[:error] = "Can't add you to this chat room please try after some time"
    end
    redirect_to user_path
  end
end
