class UsersController < ApplicationController
  # GET /users
  # GET /users.xml

#  before_filter :require_login, :only => [:favorite, :unfavorite]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      redirect_to register_path
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(profile_path(:id => @user.id), :notice => 'User was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end

  def hot
    @users = User.where("level >= ?", 5).paginate(:per_page => 25, :page => params[:page])
  end

  def search_tag
    @users = nil
    @tag = Tag.where("name like ?", "%#{params[:tag_name]}%").limit(1).first
    if @tag.nil?
      @users = []
    else
      @users = @tag.users
    end
  end

  def favorite
    @favorited_user = User.find(params[:id])
    if current_user.masters.exists?(@favorited_user.id)
      render :json => FAIL_JSON
    else
      current_user.masters << @favorited_user
      render :json => SUCCESS_JSON
    end
  end

  def unfavorite
    @un_favorite_user = User.find(params[:id])
    unless current_user.masters.exists?(@un_favorite_user.id)
      render :json => FAIL_JSON
    else
      current_user.masters.delete(@un_favorite_user)
      render :json => SUCCESS_JSON
    end
  end

  def masters
    @user = current_user
    @masters = @user.masters
  end

  def followers
    @user = current_user
    @followers = @user.followers
  end
end
