class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.string :name, null: false
      t.text :description
      t.st_polygon :focus_area, null: false

      t.index :focus_area, using: :gist

      t.timestamps null: false
    end
  end
end
