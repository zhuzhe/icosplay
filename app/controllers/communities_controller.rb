class CommunitiesController < ApplicationController
  # GET /communities
  # GET /communities.xml

  before_filter :require_login, :only => [:new, :create, :update, :edit]

  def index
    @communities = Community.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @communities }
    end
  end

  # GET /communities/1
  # GET /communities/1.xml
  def show
    @community = Community.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @community }
    end
  end

  # GET /communities/new
  # GET /communities/new.xml
  def new
    @community = Community.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @community }
    end
  end

  # GET /communities/1/edit
  def edit
    @community = Community.find(params[:id])
  end

  # POST /communities
  # POST /communities.xml
  def create
  end

  # PUT /communities/1
  # PUT /communities/1.xml
  def update
  end

  # DELETE /communities/1
  # DELETE /communities/1.xml
  def destroy 
  end

  def choice

  end

  def me  
  end
end
