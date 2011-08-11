module ApplicationHelper
  def login?
    true if session[:user_id]
  end

  def current_user
    if login?
      User.find(session[:user_id])
    end
  end
end
