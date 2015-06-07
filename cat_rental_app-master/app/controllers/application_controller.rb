class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :login!, :current_user

  private

  def login!(user)
    @current_user = user
    device = user.sessions.create
    session[:session_token] = device.token
    device.update!(
      device: request.env["HTTP_USER_AGENT"]
        .match(/\(([^\)]+)\)/).to_a.first)
  end

  def current_user
    return nil if session[:session_token].nil?
    device = Session.find_by(token: session[:session_token])
    return nil if device.nil?
    @current_user ||= User.find(device.user_id)
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end

  def redirect_if_not_logged_in
    redirect_to cats_url unless current_user
  end

end
