class UsersController < ApplicationController

  before_filter :require_login, :only => [:favorite, :unfavorite, :edit, :update]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
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
    @user.avatar = Avatar.create(:url => Avatar::DEFAULT)
    @user.birthday = Date.new(Time.now.year - params[:age].to_i)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      puts @user.errors.inspect
      redirect_to register_path
    end
  end

  def update
  end

  def destroy
   
  end

  def hot
    @users = User.order("rand()").paginate(:per_page => 20, :page => params[:page])
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
