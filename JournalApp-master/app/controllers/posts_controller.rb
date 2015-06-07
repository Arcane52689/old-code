class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post
    else
      render json: @post.errors, status: 422
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: 422
    end
  end


  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: @post
    else
      render json: "nope", status:422
    end
  end

  private
    def post_params
      params.require(:post).permit(:body, :title)

    end
end
