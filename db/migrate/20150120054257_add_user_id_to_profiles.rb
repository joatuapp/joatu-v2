class AddUserIdToProfiles < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.integer :user_id, null: false, after: :id
    end

    add_foreign_key :profiles, :users, on_delete: :cascade
  end
end
