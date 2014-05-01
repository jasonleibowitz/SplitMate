class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    current_user.admin if current_user
  end

  def require_authentication
    flash[:auth_error] = 'You must be logged in to view that page'
    redirect_to login_path unless current_user
  end

  def require_admin_authentication
    redirect_to root_path unless current_admin
  end

  def require_usershow_authorization
    unless current_user.apartment.users.include?(@user)
      redirect_to current_user
      flash[:authorization_error] = 'You do not have permission to view that page'
    end
  end

  def require_apt_authorization
    unless current_user.apartment.id == @apartment.id
      redirect_to current_user
      flash[:authorization_error] = 'You do not have permission to view that page'
    end
  end

  def require_edit_authorization
    unless current_user == @user
      redirect_to current_user
      flash[:authorization_error] = "You do not have permission to view that page"
    end
  end

end

