class AlbumsController < ApplicationController

  before_filter :require_login, :only => [:create, :update]  
  
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.paginate(:per_page => 20, :page => params[:page]) 
  end  
  
end
