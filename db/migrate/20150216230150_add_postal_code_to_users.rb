class AddPostalCodeToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :postal_code, limit: 32
    end
  end
end
