class CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def show
    @cities = City.all
    @city = City.find params[:id]
    @users = @city.users
  end
end
