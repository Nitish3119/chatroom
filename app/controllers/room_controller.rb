class RoomController < ApplicationController
  def show_room
    @chat_room =Room.find_by(id: params[:room_id])
    @users = @chat_room.user
    @all_users = User.all_except(@users)
    @message = Message.new
    @messages = @chat_room.messages.custom_display
  end

  def new
    @room = Room.new
  end

  def create
    title = params[:room][:title]
    is_private = params[:room][:is_private] == '1'
    @room = Room.create(title: title, created_by: current_user.id, is_private: is_private)
    member = Member.create(user_id: current_user.id, room_id: @room.id)
    flash[:success] = "Room creates Successfully"
    redirect_to user_path
  end

  def delete_chat_room
    room = Room.find_by(id: params[:room_id])
    if room.destroy
      flash[:success] = "Chat room deleted Successfully"
    else
      flash.now[:error] = "Cannot delete chat room at this time please try after some time"
    end
    redirect_to user_path
  end

  def add_member
    user = User.find_by(id: params[:user_id])
    member = Member.new(user_id: params[:user_id], room_id: params[:room_id])
    if member.save
      flash[:success] = "#{user.username} is now added to this chat room"
    else
      flash.now[:error] = "Cannot add user at this time please try after some time"
    end
    redirect_to room_show_room_path
  end

  def remove_member
    user = User.find_by(id: params[:user_id])
    member = Member.find_by(user_id: params[:user_id], room_id: params[:room_id])
    if member.destroy
      flash[:success] = "#{user.username} is removed from this chat room"
    else
      flash.now[:error] = "Cannot remove user at this time please try after some time"
    end
    redirect_to room_show_room_path
  end

  def leave_room
    member = Member.find_by(user_id: params[:id], room_id: params[:room_id])
    if member.destroy
      flash[:success] = "You left the chat room"
    else
      flash.now[:error] = "Can't leave this chat room please try after some time"
    end
    redirect_to user_path
  end
end
