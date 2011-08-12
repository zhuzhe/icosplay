module ApplicationHelper

  JAVASCRIPT = 'javascript:void(0)'

  def login?
    true if session[:user_id]
  end

  def current_user
    if login?
      User.find(session[:user_id])
    end
  end
end
