class AlbumsController < ApplicationController

  before_filter :require_login, :only => [:create, :update]

  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.paginate(:per_page => 20, :page => params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @album }
    end
  end

  def me
    @user = current_user
    @album = current_user.album
    @photos = @album.photos
#    if @album.id.to_s == params[:id]
#      @photos = @album.photos
#    else
#      redirect_to login_path
#    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
  end


  def slide
    @photos = Photo.limit(10)
  end
end
