class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.belongs_to :pod, index: false, null: true

      t.timestamps null: false
    end

    add_foreign_key :events, :pods
  end
end
