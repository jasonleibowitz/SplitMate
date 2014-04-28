class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:login_error] = 'Invalid email and/or password'
      render 'new'
    end
  end

  def destroy
    flash[:auth_error] = nil
    session[:user_id] = nil
    redirect_to login_path
  end

end
