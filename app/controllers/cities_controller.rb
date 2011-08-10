class CitiesController < ApplicationController
  def show
    @city = City.find params[:id]
    @users = @city
  end
end
