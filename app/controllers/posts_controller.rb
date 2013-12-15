class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'Post created!  Copy the link to share.'
      redirect_to real_post_path(@post)
    else
      # TODO: Restore from LocalStorage
      flash[:alert] = 'Sorry! There was a problem creating your post.'
      redirect_to new_post_path
    end
  end

  def show
    @post = Post.find_by_hashed_key(params[:id])
  end

  def edit
    @post = Post.find_by_hashed_key(params[:id])
  end

  def update
    # TODO: Make the edit form send the hashed key
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:success] = 'Post updated!'
    else
      flash[:alert] = 'Sorry! There was a problem editing your post.'
    end

    redirect_to real_post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def real_post_path(post)
    post_slug_path(post.hashed_key, post.title_slug)
  end

end