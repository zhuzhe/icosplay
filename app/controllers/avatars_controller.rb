class AvatarsController < ApplicationController
  # GET /avatars
  # GET /avatars.xml
  def index
    @avatars = Avatar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @avatars }
    end
  end

  # GET /avatars/1
  # GET /avatars/1.xml
  def show
    @avatar = Avatar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @avatar }
    end
  end

  # GET /avatars/new
  # GET /avatars/new.xml
  def new
    @avatar = Avatar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @avatar }
    end
  end

  # GET /avatars/1/edit
  def edit

  end

  def create

  end

  # PUT /avatars/1
  # PUT /avatars/1.xml
  def update
    @user = current_user
    uploaded_io = params[:avatar]
    @avatar = @user.avatar

    File.open(@avatar.id2path, 'w') do |file|
      file.write(uploaded_io.read)
    end

    @avatar.url = @avatar.id2relative_path
    @avatar.save

    redirect_to user_path(@user)
  end

  # DELETE /avatars/1
  # DELETE /avatars/1.xml
  def destroy 
  end 
  
end
