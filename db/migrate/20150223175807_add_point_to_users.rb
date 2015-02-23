class AddPointToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_location, :st_point
    add_index :users, :home_location, using: :gist
  end
end
