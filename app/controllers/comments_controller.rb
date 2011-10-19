class CommentsController < ApplicationController

  before_filter :require_login, :only => [:create, :update]   
  
  def create
    if login?
      @comment = Comment.new(params[:comment].merge(:user_id => session[:user_id]))
      if @comment.save
        redirect_to photo_path(:id => params[:comment][:photo_id])
      end
    else
      redirect_to login_path
    end
  end 
  
end
