class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'Post created!  Copy the link to share.'
      redirect_to post_slug_path(@post.hashed_key, @post.title_slug)
    else
      # TODO: Restore from LocalStorage
      flash[:alert] = 'Sorry! There was a problem creating your post.'
      redirect_to new_post_path
    end
  end

  def show
    hashed_key = params[:id]
    unhashed_key = Post.unhash_key(hashed_key)
    @post = Post.find(unhashed_key)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end