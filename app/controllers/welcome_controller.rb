class WelcomeController < ApplicationController
  def index
    @hot_users = User.where("level >= ?", 5).limit(12)
    @top_photos = Photo.order('count DESC, id DESC').limit(12)
    @pop_tags = Tag.where(:level => 0).limit(15)
    @current_user = current_user
  end
end
