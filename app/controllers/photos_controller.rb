class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.xml

  before_filter :require_login, :only => [:favorite, :new, :upload]

  def index
    @photos = Photo.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new
    @user = current_user
    @pop_tags = Tag.limit(10)
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
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
      file_suffix = uploaded_io.original_filename.split('.').last
      @photo = Photo.create(:album_id => current_user.album.id, :description => params[:description])
      @photo.web_url = @photo.uri = @photo.id2relative_path + '.' + file_suffix

      File.open(@photo.id2path + '.' + file_suffix, 'w') do |file|
        file.write(uploaded_io.read)
      end

      @photo.tag_ids =  params[:tag].split(' ').inject([]) do |all, tag_name|
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

end
