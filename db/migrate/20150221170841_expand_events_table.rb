class ExpandEventsTable < ActiveRecord::Migration
  def up
    add_column :events, :location, :geometry, geographic: true
    add_index :events, :location, using: :gist
    
    add_column :events, :address, :json

    add_column :events, :created_by_user_id, :integer
    add_foreign_key :events, :users, column: :created_by_user_id

    add_column :events, :organization_id, :integer
    add_foreign_key :events, :organizations
  end

  def down
    remove_column :events, :organization_id
    remove_column :events, :created_by_user_id
    remove_column :events, :address, :json
    remove_column :events, :location, :geometry, geographic: true
  end
end
