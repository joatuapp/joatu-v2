class AddTimestampsToCapsTransactions < ActiveRecord::Migration
  def change
    add_column :caps_transactions, :created_at, :datetime
    add_column :caps_transactions, :updated_at, :datetime
  end
end
