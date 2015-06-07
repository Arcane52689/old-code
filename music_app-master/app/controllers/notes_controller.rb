class NotesController < ApplicationController





  def create
    @note = Track.find(params[:track_id]).notes.new(
    user_id: current_user.id,
    body: params[:note][:body]
    )
    if @note.save
      flash[:success] = "Note successfully created"
    else
      flash[:errors] = "Wow. One requirement, and you failed it."
    end
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    if current_user.id == @note.user_id || current_user.admin?

      if @note.destroy

        flash[:success] = "That poor note... What did he ever do to you?"
        redirect_to track_url(@note.track_id)
      else
        flash[:danger] = "you need more practice at destroying things"
      end
    else
      render status: :forbidden, text: "You are a bad person"
    end

  end


end
