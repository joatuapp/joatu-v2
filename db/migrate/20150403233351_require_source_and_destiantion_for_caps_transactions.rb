class RequireSourceAndDestiantionForCapsTransactions < ActiveRecord::Migration
  def change
    change_column_null :caps_transactions, :source_id, false
    change_column_null :caps_transactions, :source_type, false
    change_column_null :caps_transactions, :destination_id, false
    change_column_null :caps_transactions, :destination_type, false
  end
end
