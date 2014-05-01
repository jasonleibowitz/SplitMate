class UsersController < ApplicationController

  before_action :require_authentication, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    require_usershow_authorization
    @chores = @user.chores
    # @completed_chores = @user.chore_histories
    @sorted_chore_histories = @user.chore_histories.order(created_at: :desc)

    respond_to do |format|
      format.html { }
      format.json { render json: {msg: params[:data]} }
    end
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
    require_edit_authorization
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if params[:vacation] == "on"
      @user.vacation_mode(true)
    elsif params[:vacation] == "off"
      @user.vacation_mode(true)
    end
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
    @user.dollar_balance = 0
    @user.admin = false
    @user.password = 'password'
    @user.password_confirmation = 'password'
    @user.apartment = @apartment
    if @user.save!
      UserMailer.roommate_welcome(@user).deliver
    end
    redirect_to @apartment
  end

  def redeem_points
    @user = User.find(params[:id])

  end

  def spendpoints
    cost_key = {"spendpoints" => 50}

    @user = User.find(params[:id])
    @chore = Chore.find(params[:chore])
    @roommate = User.find(params[:roommate])

    if @roommate.vacation = true
      flash[:points_error] = "You cannot assign a chore to a roommate that is out of town."
      render 'redeem_points'
    else
      # Assign the chore to the chosen roommate
      @chore.assign_chore(@roommate)

      # Remove possible points from this user's total week points
      # and remove cost to reassign chore from user
      @user.total_week_points -= @chore.points_value
      @user.points_balance -= cost_key[params[:action]]
      @user.save!

      # Send email to roommate letting them know they've been given a chore
      UserMailer.chored(@roommate, @user, @chore).deliver

      redirect_to @user
    end
  end

  def make_payment
    @user = User.find(params[:id])
  end

  def pay
    @user = User.find(params[:id])
    @roommate = User.find(params[:roommate])
    @payment = params[:payment]

    @user.make_payment(@roommate, @payment)
    redirect_to @user

  end

  def home
    if current_user && current_user.apartment != nil
      redirect_to current_user.apartment
    elsif current_user && current_user.apartment == nil
      redirect_to current_user
    else
      redirect_to login_path
    end
  end


  private
  def user_params
    return params.require(:user).permit(:first_name, :last_name, :email, :avatar, :password, :password_confirmation)
  end

  def roommate_params
    return params.require(:user).permit(:first_name, :last_name, :email)
  end

end
