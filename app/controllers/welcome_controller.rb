class WelcomeController < ApplicationController
  def index
    @hot_users = User.where("level >= ?", 5).limit(18)
    @top_photos = Photo.order('count DESC, id DESC').limit(14)
    @current_user = current_user
  end
end
