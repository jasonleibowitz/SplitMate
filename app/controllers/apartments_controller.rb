class ApartmentsController < ApplicationController

  def index
    @apartments = Apartment.all
  end

  def show
    @apartment = Apartment.find(params[:id])
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.save
    current_user.apartment = @apartment
    redirect_to @apartment
  end

  def edit
    @apartment = Apartment.find(params[:id])
  end

  def update
    @apartment = Apartment.find(params[:id])
    @apartment.update(apartment_params)
    redirect_to @apartment
  end

  def destroy
    @apartment = Apartment.find(params[:id])
    @apartment.destroy
    redirect_to root_path
  end

  private
  def apartment_params
    return params.require(:apartment).permit(:name, :street, :apt, :zipcode)
  end

end
