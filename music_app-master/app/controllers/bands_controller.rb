class BandsController < ApplicationController

  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_activated
  before_action :redirect_if_not_admin, only: [:create, :destroy, :update]

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = "#{@band.name} has successfully been created!"
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def new
    @band = Band.new
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:success] = "We are no longer who we once were"
      redirect_to band_url(@band)
    else
      render :edit
    end#
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.destroy
      flash[:success] = "#{@band.name} is now a resident of Alderaan"
      redirect_to bands_url
    else
      flash[:danger] = "You can not destroy what does not exist"
    end
  end


  def band_params
    params.require(:band).permit(:name)
  end
end
