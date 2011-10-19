class WelcomeController < ApplicationController

  before_filter :get_pop_tags

  def index
    @top_photos = Photo.get_hots.paginate(:per_page => 20, :page => params[:page])
    @current_user = current_user
  end
end
