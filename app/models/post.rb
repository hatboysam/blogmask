require 'base64'

class Post < ActiveRecord::Base
  has_secure_password

  def self.find_by_hashed_key(hashed)
    find(unhash_key(hashed))
  end

  def self.unhash_key(hashed)
    Base64.strict_decode64(hashed).to_i
  end

  def hashed_key
    Base64.strict_encode64(id.to_s)
  end

  def title_slug
    title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def body_preview
    # TODO make it work with links
    stripped = body.gsub(/<[^>]+>/," ").strip.squeeze(' ')
    return stripped
  end

end