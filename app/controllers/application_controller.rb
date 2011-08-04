class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
     redirect_to login_path unless login?
  end

  def login?
    true if session[:user_id]
  end

  def current_user
    if login?
      User.find(session[:user_id])
    end
  end
end
