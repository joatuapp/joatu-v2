class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :summary
      t.text :description

      t.timestamps null: false
    end
  end
end
