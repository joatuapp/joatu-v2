class AddUserIdToOffers < ActiveRecord::Migration
  def change
    change_table :offers do |t|
      t.integer :user_id, null: false
      t.add_foreign_key :offers, :users
    end
  end
end
