class AddUserIdToRequests < ActiveRecord::Migration
  def change
    change_table :requests do |t|
      t.integer :user_id, null: false, after: :id
    end

    add_foreign_key :requests, :users, on_delete: :cascade
  end
end
