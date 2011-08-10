class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.all

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
    unless params[:album_id]
      redirect_to new_album_photo_path(params[:album_id])
    else
      uploaded_io = params[:photo]
      file_name = Time.now.to_s + '.' + uploaded_io.original_filename.split('.').last
      path = Rails.root.join('public', 'uploads', file_name)
      File.open(path, 'w') do |file|
        file.write(uploaded_io.read)
        @photo = Photo.create(:album_id => params[:album_id], :uri => '/uploads/' + file_name)
      end
      redirect_to me_album_path(params[:album_id])
    end

  end

  def next
    @next_photo  = Photo.where("album_id = ? And id > ?", params[:album_id], params[:id]).limit(1).first
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
    @photos = nil
    @tag = Tag.where("name like ?", "%#{params[:tag_name]}%").limit(1).first
    if @tag.nil?
      @photos = []
    else
      @photos = @tag.photos
    end

  end
end
