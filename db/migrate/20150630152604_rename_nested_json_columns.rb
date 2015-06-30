class RenameNestedJsonColumns < ActiveRecord::Migration
  def change
    rename_column :organizations, :address_json, :address
    rename_column :events, :address_json, :address
    rename_column :users, :preferences_json, :preferences
  end
end
