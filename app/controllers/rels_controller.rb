class RelsController < ApplicationController
  # GET /rels
  # GET /rels.xml
  def index
    @rels = Rel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rels }
    end
  end

  # GET /rels/1
  # GET /rels/1.xml
  def show
    @rel = Rel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rel }
    end
  end

  # GET /rels/new
  # GET /rels/new.xml
  def new
    @rel = Rel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rel }
    end
  end

  # GET /rels/1/edit
  def edit
    @rel = Rel.find(params[:id])
  end

  # POST /rels
  # POST /rels.xml
  def create
    @rel = Rel.new(params[:rel])

    respond_to do |format|
      if @rel.save
        format.html { redirect_to(@rel, :notice => 'Rel was successfully created.') }
        format.xml  { render :xml => @rel, :status => :created, :location => @rel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rels/1
  # PUT /rels/1.xml
  def update
    @rel = Rel.find(params[:id])

    respond_to do |format|
      if @rel.update_attributes(params[:rel])
        format.html { redirect_to(@rel, :notice => 'Rel was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rels/1
  # DELETE /rels/1.xml
  def destroy
    @rel = Rel.find(params[:id])
    @rel.destroy

    respond_to do |format|
      format.html { redirect_to(rels_url) }
      format.xml  { head :ok }
    end
  end
end
