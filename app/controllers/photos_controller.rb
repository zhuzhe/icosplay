class PhotosController < ApplicationController

  before_filter :require_login, :only => [:favorite, :new, :upload]
  before_filter :get_pop_tags, :only => [:recommend, :latest, :index]

  def index
    @photos = Photo.limit(100).paginate(:per_page => 20, :page => params[:page])
    @pop_tags = Tag.limit(20)
  end

  def show
    @photo = Photo.find(params[:id])
    @comments = Comment.where(:photo_id => @photo.id).order("created_at DESC")
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @photo }
    end
  end

  def new
    @photo = Photo.new
    @user = current_user
    @pop_tags = Tag.limit(10)
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @photo }
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to(@photo, :notice => 'Photo was successfully created.') }
        format.xml { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to(@photo, :notice => 'Photo was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml { head :ok }
    end
  end

  def upload

    uploaded_io = params[:photo]
    @photo = Photo.create(:album_id => current_user.album.id, :description => params[:description])

    f= File.open(@photo.id2path, 'w') do |file|
      file.write(uploaded_io.read)
    end

    @photo.create_thumb

    @photo.tag_ids = params[:tag].split(' ').inject([]) do |all, tag_name|
      if ((tag = Tag.find_by_name(tag_name)).nil?)
        tag = Tag.create(:name => tag_name)
      end
      all << tag.id
    end

    @photo.save


    redirect_to photo_path(@photo)
  end

  def next
    @next_photo = Photo.where("album_id = ? And id > ?", params[:album_id], params[:id]).limit(1).first
    if @next_photo.nil?
      @next_photo = Photo.where(:album_id => params[:album_id]).limit(1).first
    end

    redirect_to photo_path(@next_photo)
  end

  def inc
    @photo = Photo.find(params[:id])
    @photo.count = @photo.count || 0 + 1
    if @photo.save
      render :text => 'success'
    end
  end

  def search_tag
    @tag_name = params[:tag_name]
    @photos = Photo.joins(:tags).where("tags.name like ?", "%#{params[:tag_name]}%").paginate(:page => params[:page], :per_page => 30)
    @relative_tags = Tag.limit(10)
  end

  def by_tag
    @tag = Tag.find(params[:tag_id])
    @photos = Photo.joins(:tags).where("tags.id = ?", @tag.id).paginate(:page => params[:page], :per_page => 30)
    @relative_tags = []
    @relative_photos = []
  end

  def favorite
    @photo = Photo.find(params[:id])
    if current_user.favorite_photos.exists?(@photo.id)
      respond_to do |format|
        format.json { render :json => FAIL_JSON }
      end
    else
      current_user.favorite_photos << @photo
      render :json => SUCCESS_JSON
#      respond_to do |format|
#        format.json {render :json => SUCCESS_JSON}
#      end
    end
  end

  def favorited
    @user = User.find(params[:user_id])
    @photos = @user.favorite_photos
  end

  def search
    @tag_name = params[:tag_name]
    @photos = Photo.joins(:tags).where("tags.name like ?", "%#{params[:tag_name]}%").paginate(:page => params[:page], :per_page => 20)
  end

  def recommend
    @photos = Photo.get_recommends.paginate(:per_page => 20, :page => params[:page])
  end

  def latest
    @photos = Photo.order('created_at DESC').limit(100).paginate(:per_page => 20, :page => params[:page])
  end


end
