class ApartmentsController < ApplicationController

  def index
    @apartments = Apartment.all
  end

  def show
    @apartment = Apartment.find(params[:id])
    @roommates = @apartment.users
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)
    if @apartment.avatar_file_name == nil
      @apartment.default_avatar = Google.find_latlon(@apartment.street, @apartment.zipcode)
    end
    @apartment.save
    @user = current_user
    @user.apartment = @apartment
    @user.save!
    redirect_to @apartment
  end

  def edit
    @apartment = Apartment.find(params[:id])
  end

  def update
    @apartment = Apartment.find(params[:id])
    @apartment.update(apartment_params)
    if @apartment.avatar_file_name == nil
      @apartment.default_avatar = Google.find_latlon(@apartment.street, @apartment.zipcode)
      @apartment.save!
    end
    redirect_to @apartment
  end

  def destroy
    @apartment = Apartment.find(params[:id])
    @apartment.destroy
    redirect_to root_path
  end

  def add_roommates
    @apartment = current_user.apartment
    @num = @apartment.users.length + 1
    @user = User.new
  end

  private
  def apartment_params
    return params.require(:apartment).permit(:name, :street, :apt, :zipcode, :avatar, :avatar_file_name)
  end

end
