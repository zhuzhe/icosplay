class CommentsController < ApplicationController

  before_filter :require_login, :only => [:create, :update]

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    if login?
      @comment = Comment.new(params[:comment].merge(:user_id => session[:user_id]))
      if @comment.save
        redirect_to photo_path(:id => params[:comment][:photo_id])
      end
    else
      redirect_to login_path
    end

  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
  end
  
end
