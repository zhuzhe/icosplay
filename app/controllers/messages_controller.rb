class MessagesController < ApplicationController

  before_filter :require_login, :only => [:create]   
  
  def edit
    @message = Message.find(params[:id])
  end 
  
  def create
    @message = Message.new(params[:message])
    @message.from = current_user
    @message.save
    redirect_to user_path(@message.to) + "#messages"
  end 
  
end
