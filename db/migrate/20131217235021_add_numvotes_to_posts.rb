class AddNumvotesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :numvotes, :int, default: 0
    add_column :posts, :lastvoted, :datetime
  end
end
