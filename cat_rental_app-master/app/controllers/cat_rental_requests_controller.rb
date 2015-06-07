class CatRentalRequestsController < ApplicationController
  before_action :confirm_ownership, only: [:approve, :deny]

  def new
    if params[:cat_rental_request]
      @request = CatRentalRequest.new(request_params)
    else
      @request = CatRentalRequest.new
    end
  end

  def create
    @request = current_user.requests.new

    if @request.update(request_params)
      flash[:success] = "Cat request submitted!"
      redirect_to cat_rental_request_url(@request)
    else
      flash[:errors] = @request.errors.full_messages
      redirect_to new_cat_rental_request_url
    end
  end

  def show
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
  end

  def destroy
    @request = CatRentalRequest.find(params[:id])

    if @request
      @request.destroy
      flash[:success] = "NO CAT FOR YOU."
    else
      flash[:danger] = "What are you doing? You didn't even have a request. Go home, you must be tired."
    end

    redirect_to cats_url
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
    @request.approve!

    if @request.errors.any?
      flash.now[:errors] = @request.errors.full_messages
    else
      flash[:success] = "Cat rental approved"
    end

    redirect_to cat_url(@cat)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
    @request.deny!
    flash[:success] = "Cat rental denied!"

    redirect_to cat_url(@cat)
  end

  def request_params
    params
      .require(:cat_rental_request)
      .permit(:start_date, :end_date, :cat_id)
  end

  def confirm_ownership
    cat = CatRentalRequest.find(params[:id]).cat
    unless current_user.id == cat.owner.id
      flash[:danger] = "That's not your cat!".upcase
      redirect_to cat_url(cat)
    end
  end
end
