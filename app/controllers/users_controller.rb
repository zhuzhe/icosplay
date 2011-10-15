class UsersController < ApplicationController

#  before_filter :require_login, :only => [:favorite, :unfavorite]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.id == current_user_id
       redirect_to home_user_path(@user)
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.tag_ids = Tag.create_from_text(params[:tags])
    @user.avatar = Avatar.create(:url => '/images/avatars/default.jpg')
    @user.birthday = Date.new(Time.now.year - params[:age].to_i)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path(:id => @user.id)
    else
      redirect_to register_path
    end
  end

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

  def by_tag
    @tag = Tag.find(params[:tag_id])
    @users = User.joins(:tags).where("tags.id = ?", @tag.id).paginate(:page => params[:page], :per_page => params[:per_page])
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
    @user = User.find(params[:id])
    @masters = @user.masters
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def add_tag_for_register

  end

  def home
    @user = current_user
  end
end
