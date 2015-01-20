class AddUserIdToOffers < ActiveRecord::Migration
  def change
    change_table :offers do |t|
      t.integer :user_id, null: false, after: :id
    end

    add_foreign_key :offers, :users, on_delete: :cascade
  end
end
