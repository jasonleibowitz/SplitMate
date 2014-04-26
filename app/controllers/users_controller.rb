class UsersController < ApplicationController

  before_action :require_authentication

  def index

  end

  def show

  end

  def new

  end

  def update

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def user_params
    return params.requier(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
