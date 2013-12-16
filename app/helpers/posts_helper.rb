module PostsHelper

  def sign_in?(post, password)
    if post.authenticate(password)
      cookies.signed[:post_id] = post.id
      self.current_post = post
      return true;
    else
      return false;
    end
  end

  def current_post
    @current_post
  end

  def current_post=(post)
    @current_post = post
  end

  def signed_in?(post)
    (!post.nil? && (post.id == cookies.signed[:post_id]))
  end

  def sign_out
    cookies.delete(:post_id)
    self.current_post = nil
  end

end