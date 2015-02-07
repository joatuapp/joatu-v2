class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.belongs_to :from_user
      t.belongs_to :to_user
      t.text :reference
      t.integer :rating
      t.belongs_to :offer, index: true

      t.timestamps null: false
      t.timestamp :deleted_at

      t.index [:to_user_id, :from_user_id], unique: true
    end
  end
end
