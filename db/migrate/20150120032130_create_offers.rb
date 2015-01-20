class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :title
      t.string :summary
      t.text :description

      t.timestamps null: false
    end
  end
end
