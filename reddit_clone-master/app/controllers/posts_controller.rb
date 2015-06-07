class PostsController < ApplicationController

  before_action :require_user_be_post_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "New post created!"
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Post successfully updated!"
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @subs = @post.subs
    @all_comments = @post.comments_by_parent_id
    # @all_comments = @post.comments.includes(:author)
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to user_url(current_user)
  end

  def require_user_be_post_author
    @post = Post.find(params[:id])
    unless @post.author_id == current_user_id
      flash[:danger] = "DON'T TOUCH OTHER PEOPLE'S STUFF. IT'S NOT NICE"
      redirect_to subs_url
    end
  end



  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end


end
