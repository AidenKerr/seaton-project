class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post has been saved"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end