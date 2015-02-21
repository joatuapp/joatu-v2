class RenameUserPreferencesToPreferencesJson < ActiveRecord::Migration
  def change
    rename_column :users, :preferences, :preferences_json
  end
end
