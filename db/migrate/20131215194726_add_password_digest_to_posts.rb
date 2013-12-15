class AddPasswordDigestToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :password_digest, :string
  end
end
