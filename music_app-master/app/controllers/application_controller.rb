class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def redirect_if_not_admin
    flash[:danger] = "Only admins can do that.  Please don't try again if you don't wan't to be exterminated"
    redirect_to bands_url unless current_user.admin?
  end

  def login!(user)
    @current_user = user
    @current_user.reset_session_token!
    session[:session_token] = @current_user.session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def redirect_if_not_activated
    redirect_to user_url(current_user) unless current_user.activated
  end
end
