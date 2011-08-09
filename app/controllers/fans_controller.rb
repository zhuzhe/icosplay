class FansController < ApplicationController
  # GET /fans
  # GET /fans.xml
  def index
    @fans = Fan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fans }
    end
  end

  # GET /fans/1
  # GET /fans/1.xml
  def show
    @fan = Fan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fan }
    end
  end

  # GET /fans/new
  # GET /fans/new.xml
  def new
    @fan = Fan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fan }
    end
  end

  # GET /fans/1/edit
  def edit
    @fan = Fan.find(params[:id])
  end

  # POST /fans
  # POST /fans.xml
  def create
    @fan = Fan.new(params[:fan])

    respond_to do |format|
      if @fan.save
        format.html { redirect_to(@fan, :notice => 'Fan was successfully created.') }
        format.xml  { render :xml => @fan, :status => :created, :location => @fan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fans/1
  # PUT /fans/1.xml
  def update
    @fan = Fan.find(params[:id])

    respond_to do |format|
      if @fan.update_attributes(params[:fan])
        format.html { redirect_to(@fan, :notice => 'Fan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fans/1
  # DELETE /fans/1.xml
  def destroy
    @fan = Fan.find(params[:id])
    @fan.destroy

    respond_to do |format|
      format.html { redirect_to(fans_url) }
      format.xml  { head :ok }
    end
  end
end
