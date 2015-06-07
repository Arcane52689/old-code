class CatsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:new, :create]
  before_action :current_user_not_owner, only: [:edit, :update, :destroy]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def create
    @cat = current_user.cats.new(cat_params)

    if @cat.save!
      flash[:success] ="YOU MADE A CAT!!!!!!"
      redirect_to cat_url @cat
    else
      flash.now[:errors] = @cat.errors.full_messages
      redirect_to new_cat_url
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    
    if @cat
      @cat.destroy
      flash[:success] = "You killed it! You monster! You shall be punished!"
    else
      flash[:danger] = "Lich cat cannot be killed."
    end

    redirect_to cats_url
  end


  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      flash[:success] = "WHY DID YOU CHANGE ME!  WHAT WAS WRONG?"
      redirect_to cat_url @cat
    else
      flash.now[:errors] = @cat.errors.full_messages
      redirect_to cat_url @cat
    end
  end

  def cat_params
    params
      .require(:cat)
      .permit(:birth_date,:name,:color,:sex, :description)
  end

  def current_user_not_owner
    unless current_user.id == Cat.find_by(id: params[:id]).user_id
      flash[:danger] = "That's not your cat!".upcase
      redirect_to cats_url
    end
  end

end
