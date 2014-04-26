class UsersController < ApplicationController

  before_action :require_authentication, only: [:index, :show, :edit, :update, :destroy]

  def index

  end

  def show
    @user = User.find(params[:id])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.points_balance = 0
    @user.points_lifetime = 0
    @user.completed_week_points = 0
    @user.total_week_points = 0
    @user.admin = false
    @user.save

    redirect_to @user
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def user_params
    return params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
