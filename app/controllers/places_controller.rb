class PlacesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_place, except: [:new, :create]

  def new
    @place = Place.new
  end

  def create
    @place = Place.create(place_params)
    if @place.save
      flash[:success] = 'Place was added to the database successfully'
      redirect_to place_path(@place)
    else
      flash[:danger] = 'Something went wrong. Please check the form fields and submit again'
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @place.update(place_params)
      flash[:success] = 'Place was updated successfully !'
      redirect_to place_path(@place)
    else
      flash[:danger] = 'Something went wrong. Please check the form fields and submit again'
      render :edit
    end
  end

  def destroy
    @place.destroy
    flash[:success] = 'Place was deleted successfully'
    redirect_to root_path
  end

  private
  def set_place
    @place = Place.friendly.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :address, :type)
  end
end
