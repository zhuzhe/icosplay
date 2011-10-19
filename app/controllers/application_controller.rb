class ApplicationController < ActionController::Base
  protect_from_forgery

  SUCCESS = "success"
  FAIL = "fail"

  SUCCESS_JSON = {:status => SUCCESS}
  FAIL_JSON = {:status => FAIL}

  def require_login
    unless login?
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render :json => FAIL_JSON }
      end
    end
  end

  def login?
    true if session[:user_id]
  end

  def current_user
    if login?
      User.find(session[:user_id])
    end
  end

  def current_user_id
    session[:user_id]
  end


  def get_pop_tags
    @pop_tags = Tag.limit(20).order("rand()")
  end
end
