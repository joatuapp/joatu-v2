class FleshOutProfileFields < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.string :tagline
    end
  end
end
