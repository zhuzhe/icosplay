class SessionsController < ApplicationController
  def new
     session[:back_url] = request.referer
  end

  def create
     @user = User.first(:conditions => {:email => params[:email], :pwd => params[:pwd]})
     if @user
       session[:user_id] = @user.id

       redirect_to(session[:back_url] ? session[:back_url] : root_path)
     else
       redirect_to login_path
     end
  end

  def destroy
     session[:user_id] = nil
     redirect_to root_path
  end
end
