class ChangeEventLocationToPoint < ActiveRecord::Migration
  def change
    remove_column :events, :location
    add_column :events, :latlng, :st_point
    add_index :events, :latlng, using: :gist
  end
end
