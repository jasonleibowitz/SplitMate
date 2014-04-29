class UsersController < ApplicationController

  before_action :require_authentication, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @chores = @user.chores
    @completed_chores = @user.chore_histories
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
    @user.dollar_balance = 0
    if @user.avatar_file_name == nil
      @user.default_avatar
    end
    if @user.valid?
      @user.save
      UserMailer.welcome_user(@user).deliver
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    require_authorization
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    if current_user == @user
      @user.destroy
      redirect_to root_path
    else
      redirect_to logout_path
    end
  end

  def save_roommate
    @apartment = current_user.apartment
    @user = User.new(roommate_params)
    @user.points_balance = 0
    @user.points_lifetime = 0
    @user.completed_week_points = 0
    @user.total_week_points = 0
    @user.admin = false
    @user.password = 'password'
    @user.password_confirmation = 'password'
    @user.apartment = @apartment
    if @user.save!
      UserMailer.roommate_welcome(@user).deliver
    end
    redirect_to @apartment
  end

  private
  def user_params
    return params.require(:user).permit(:first_name, :last_name, :email, :avatar, :password, :password_confirmation)
  end

  def roommate_params
    return params.require(:user).permit(:first_name, :last_name, :email)
  end

end
