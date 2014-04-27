class ChoresController < ApplicationController

  def index
    @chores = Chore.all
  end

  def show
    @chore = Chore.find(params[:id])
  end

  def new
    @chore = Chore.new
    @apartment = Apartment.find(params[:apartment_id])
  end

  def create
    @chore = Chore.create(chore_params)
    @apartment = Apartment.find(params[:apartment_id])
    @chore.apartment = @apartment
    @chore.save!
    redirect_to @apartment
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    @chore = Chore.find(params[:id])
    @chore.update(chore_params)
  end

  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy
  end

  def assign_chore
    @chore = Chore.find(params[:id])
    @user = current_user
    @chore.user = @user
    @chore.save!
    redirect_to @user
  end

  def complete_chore
    @user = current_user
    @chore = Chore.find(params[:id])
    @chore.user = nil
    @chore.save!
    redirect_to @user
  end

  private

  def chore_params
    return params.require(:chore).permit(:name, :points_value, :due_date)
  end

end

