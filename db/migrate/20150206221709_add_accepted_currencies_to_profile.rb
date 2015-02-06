class AddAcceptedCurrenciesToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.json :accepted_currencies
    end
  end
end
