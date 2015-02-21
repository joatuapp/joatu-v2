class UsePostgsPointForOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :latlng
    add_column :organizations, :latlng, :st_point
    add_index :organizations, :latlng, using: :gist
  end

  def down
    remove_column :organizations, :latlng
    add_column :organizations, :latlng, :point
    add_index :organizations, :latlng, using: :gist
  end
end
