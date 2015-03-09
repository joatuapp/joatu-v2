class AddCapsBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :caps_balance, :integer, null: false, default: 0
  end
end
