class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :given_name
      t.string :surname
      t.text :about_me

      t.timestamps null: false
    end
  end
end
