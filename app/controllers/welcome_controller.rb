class WelcomeController < ApplicationController
  def index
#    @hot_users = User.where("level >= ?", 5).limit(12)
#    @top_photos = Photo.order('count DESC, id DESC').where("created_at > 2011/7/8").paginate(:per_page => 20, :page => params[:page])
    @top_photos = Photo.paginate(:per_page => 20, :page => params[:page])
    @pop_tags = Tag.where(:level => 0).limit(15)
    @current_user = current_user
  end
end
