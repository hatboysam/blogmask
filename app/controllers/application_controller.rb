class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

  def about
  end

  def contact
  end

  def browse
    @alltime = Post.top_all_time(10)
    @thisweek = Post.top_last_week(10)
  end

end
