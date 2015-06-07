class TracksController < ApplicationController

  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_activated
  before_action :redirect_if_not_admin, only: [:create, :destroy, :update]
  
  def new
    @track = Track.new(track_params)
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = "You made a god damned Track.  Be proud"
      redirect_to track_url(@track)
    else
      #flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @album.band
  end


  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      flash[:success] = "Changes have been saved"
      redirect_to track_url(@track)
    else
      render :edit
    end
  end


  def destroy
    @track = Track.find(params[:id])
    if @track.destroy
      flash[:success] = "On your way to being a true Dalek"
      redirect_to(album_url(@track.album_id))
    else
      flash[:danger] = "What is dead can never die"
      redirect_to(bands_url)
    end
  end



  def track_params
    params.require(:track).permit(:album_id,:name,:lyrics,:bonus)
  end




end
