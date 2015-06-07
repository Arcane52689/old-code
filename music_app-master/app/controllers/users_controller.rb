require 'byebug'

class UsersController < ApplicationController

  before_action :redirect_if_not_admin, only:[:index,:make_admin]


  def new

  end

  def index
    @users = User.all
  end

  def activate
    if logged_in?
      user = current_user
    else
      user = User.find(params[:user_id])
    end
  #  byebug
    if params[:activation_token] == user.activation_token
      user.activate
      login!(user) unless logged_in?
      redirect_to bands_url
    else
      flash[:danger] = "Sorry, invalid link"
      redirect_to user_url(user)
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "Welecome to the Music App"
      mail = UserMailer.welcome_email(user)
      mail.deliver_now
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def make_admin
    @user = User.find(params[:id])
    @user.toggle_admin
    redirect_to users_url
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
