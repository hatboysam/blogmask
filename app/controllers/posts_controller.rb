class PostsController < ApplicationController
  include PostsHelper
  include Category

  def new
    @post = Post.new
    @parent = Post.find_by_hashed_key(params[:reply]) unless params[:reply].nil?
  end

  def create
    @post = Post.new(post_params)
    @post.password_confirmation = params[:post][:password]

    if @post.save
      flash[:success] = 'Post created!  Make sure to copy the link somewhere, you will need it to get back to your post.'
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

    if (!signed_in?(@post))
      flash[:notice] = 'Please sign in to edit.'
      redirect_to post_signin_path(@post.hashed_key)
    end
  end

  def update
    # TODO: Make the edit form send the hashed key
    @post = Post.find(params[:id])

    if !signed_in?(@post)
      redirect_to real_post_path(@post)
    end

    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.category = params[:post][:category]

    if @post.save
      flash[:success] = 'Post updated!'
    else
      flash[:alert] = 'Sorry! There was a problem editing your post.'
    end

    # Sign out on each edit
    sign_out
    redirect_to real_post_path(@post)
  end

  def vote
    @post = Post.find_by_hashed_key(params[:id])
    @post.increment(:numvotes, 1)
    @post.lastvoted = Time.now
    @post.save
    
    respond_to do |format|
      format.json { render text: 'Voted.' }
      format.html { redirect_to real_post_path(@post) }
    end
  end

  def category
    @category = params[:category]
    # TODO: pagination...
    @posts = Post.where(category: @category).limit(20).order('numvotes DESC')
  end 

  def signin
    @post = Post.find_by_hashed_key(params[:id])
  end

  def authenticate
    @post = Post.find_by_hashed_key(params[:id])
    if sign_in?(@post, params[:password])
      flash[:success] = 'Signed in!'
      redirect_to edit_post_path(@post.hashed_key)
    else
      flash[:alert] = 'Sorry, that password was not correct.'
      redirect_to post_signin_path(@post.hashed_key)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :password, :category, :parent_id)
  end

  def real_post_path(post)
    post_slug_path(post.hashed_key, post.title_slug)
  end

end