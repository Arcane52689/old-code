class AlbumsController < ApplicationController

  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_activated
  before_action :redirect_if_not_admin, only: [:create, :destroy, :update]

  def new
    @album = Album.new(album_params)
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = "You created an album. Good for you"
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @band = @album.band
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      flash[:success]= "Changes have been made"
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      flash[:success] = "FROM ASHES TO ASHES"
      redirect_to band_url(@album.band)
    else
      flash[:danger] = "Not sure what you're trying to do here, but you can't do it"
      redirect_to bands_url
    end
  end

  def album_params
    params.require(:album).permit(:band_id, :name, :live)
  end

end
