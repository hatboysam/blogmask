class AddPostScoreIndexes < ActiveRecord::Migration
  def change
    add_index :posts, :numvotes
    add_index :posts, :lastvoted
  end
end
