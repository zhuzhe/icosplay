class CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def show
    @cities = City.all
    @city = City.find params[:id]
    @users = User.where(:city_id => @city.id).paginate(:per_page => 20, :page => params[:page])
  end
end
