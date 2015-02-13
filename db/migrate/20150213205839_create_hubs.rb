class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|
      t.string :name, null: false
      t.text :description
      t.point :latlng, null: false

      t.timestamps null: false
    end
  end
end
