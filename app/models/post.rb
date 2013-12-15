require 'base64'

class Post < ActiveRecord::Base

  def self.unhash_key(hashed)
    Base64.strict_decode64(hashed).to_i
  end

  def hashed_key
    Base64.strict_encode64(id.to_s)
  end

  def title_slug
    title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end