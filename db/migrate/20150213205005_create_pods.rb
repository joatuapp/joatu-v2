class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.string :name, null: false
      t.text :description
      t.st_polygon :focus_area, null: false
      t.integer :hub_id, null: false

      t.timestamps null: false
    end
  end
end
