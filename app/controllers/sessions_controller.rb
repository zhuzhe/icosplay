class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.first(:conditions => {:email => params[:email], :pwd => params[:pwd]})
    if @user
      session[:user_id] = @user.id
      redirect_to(request.referer.match(/\/login/) ? root_path : request.referer)
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
