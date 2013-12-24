module Category

  # All of the available categories
  @@all = [ 'Other', 'Arts', 'Business', 'Confession', 'Entertainment', 'Funny', 'Fashion', 
      'Gaming', 'Health', 'How To', 'Journal', 'Life', 'Men', 'Movies', 
      'Music', 'Opinion', 'Politics', 'Science', 'Self', 'Society', 'Rant', 
      'Religion', 'Sports', 'Technology', 'Travel', 'TV', 'Women', 'World' ]

  def self.all
    @@all
  end

end