class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      unless @comment.parent_comment_id.nil?
        redirect_to comment_url(@comment.parent_comment_id)
      else
        redirect_to post_url(@comment.post_id)
      end
    else
      redirect_to new_post_comment_url(@comment.post_id)
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @children = @comment.child_comments
    render :show
  end

  def comment_params
    params.require(:comment).
      permit(:content, :post_id, :parent_comment_id)
  end



end
