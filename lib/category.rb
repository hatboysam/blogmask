module Category

  # All of the available categories
  @@all = [ 'Other', 'Arts', 'Business', 'Confession', 'Entertainment', 'Funny', 'Fashion', 
      'Gaming', 'Health', 'How To', 'Journal', 'Life', 'Men', 'Movies/TV', 
      'Music', 'Opinion', 'Politics', 'Science', 'Self', 'Society', 'Rant', 
      'Religion', 'Sports', 'Technoloy', 'Travel', 'Women', 'World' ]

  def self.all
    @@all
  end

end