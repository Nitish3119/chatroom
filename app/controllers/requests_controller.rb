class RequestsController < ApplicationController
  def all_requests
    @requests = Request.where(approver: params[:id]).where(status: 'Active')
  end

  def requestt
    room = Room.find_by(id: params[:room_id])
    approver_id = room.created_by
    req = Request.new(requester: current_user.id, approver: approver_id, room_id: room.id, status: 'Active')
    if req.save!
      flash[:success] = "Requested to join the chat room"
    else
      flash.now[:error] = "Unable to process request at this time please try after some time"
    end
    redirect_to user_path
  end

  def withdraw
    req = Request.find_by(room_id: params[:room_id], requester: params[:id])
    if req.destroy
      flash[:success] = "Requested withdraw successful"
    else
      flash.now[:error] = "Unable to process request at this time please try after some time"
    end
    redirect_to user_path
  end

  def accept
    req = Request.find_by(id: params[:request_id])
    requester = User.find_by(id: req.requester)
    member = Member.new(room_id: req.room_id, user_id: req.requester)
    if member.save!
      flash[:success] = "#{requester.username} added to the #{req.room.title} successfully"
    else
      flash.now[:error] = "Unable to accept at the moment please try after some time"
    end
    req.destroy
    redirect_to all_requests_user_path
  end

  def reject
    req = Request.find_by(id: params[:request_id])
    req.destroy
    redirect_to all_requests_user_path
  end
end
