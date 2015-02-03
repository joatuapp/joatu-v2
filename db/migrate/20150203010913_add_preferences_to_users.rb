class AddPreferencesToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.json :preferences
    end
  end
end
