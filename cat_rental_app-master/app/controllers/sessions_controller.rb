class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new]


  def new
  end

  def index
    @sessions = current_user.sessions
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user
      login!(user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.sessions.find_by(token: session[:session_token]).destroy
    session[:session_token] = nil
    redirect_to cats_url
  end

  def destroy_specific
    Session.find(params[:id]).destroy
    render :index
  end
end
