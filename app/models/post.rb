require 'base64'

class Post < ActiveRecord::Base
  has_secure_password

  def self.find_by_hashed_key(hashed)
    find(unhash_key(hashed))
  end

  def self.unhash_key(hashed)
    Base64.strict_decode64(hashed).to_i
  end

  def self.top_all_time(num)
    all.limit(num).order('numvotes DESC')
  end

  def self.top_last_week(num)
    where("lastvoted > ?", Time.now - 7.days).limit(10).order('numvotes DESC')
  end

  def hashed_key
    Base64.strict_encode64(id.to_s)
  end

  def title_slug
    title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def body_preview
    stripped = body.gsub(/<[^>]+>/,' ').gsub('&nbsp', '').strip.squeeze(' ')
    if stripped.length <= 50
      stripped
    else
      stripped[0..50] + '...'
    end
  end

  def parent
    Post.find(parent_id) unless parent_id.nil?
  end

  def replies
    Post.where(parent_id: id)
  end

end