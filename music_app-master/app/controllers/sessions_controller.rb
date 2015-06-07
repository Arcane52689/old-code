class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user.nil?
      unless user.activated
        flash[:danger]= "Please check your email and activate your account"
        redirect_to root
      end
      flash[:danger] = "Not a valid email or password"
      redirect_to new_session_url
    else
      login!(user)
      redirect_to bands_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
