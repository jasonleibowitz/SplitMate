class ApartmentsController < ApplicationController

  before_action :require_authentication

  def index
    @apartments = Apartment.all
  end

  def show
    @apartment = Apartment.find(params[:id])
    require_authorization
    # @user = @apartment.user
    @roommates = @apartment.users
    @leaderboard = @apartment.users.order(points_balance: :desc)
    @chores = @apartment.chores.order(points_value: :desc)
    @completed_chores = ChoreHistory.where(apartment: @apartment).last_week.order(created_at: :desc)
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)
    if @apartment.avatar_file_name == nil
      @apartment.default_avatar = Google.find_latlon(@apartment.street, @apartment.zipcode)
    end
    @apartment.add_default_chores
    if @apartment.valid?
      @apartment.chore_assignment_day = "Friday"
      @apartment.save
      @user = current_user
      @user.apartment = @apartment
      @user.save!
      redirect_to @apartment
    else
      render 'new'
    end
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
    return params.require(:apartment).permit(:name, :street, :apt, :zipcode, :chore_assignment_day, :avatar, :avatar_file_name)
  end

end
