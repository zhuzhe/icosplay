class WelcomeController < ApplicationController
  def index
    @hot_users = User.where("level >= ?", 5).limit(18)
    @top_photos = Photo.order('count DESC, id DESC').limit(14)
    @pop_tags = Tag.where(:level => 0).limit(15)
    @current_user = current_user
  end
end
