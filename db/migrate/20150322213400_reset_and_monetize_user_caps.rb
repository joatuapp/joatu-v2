class ResetAndMonetizeUserCaps < ActiveRecord::Migration
  def up
    ApplicationRecord.connection.execute("UPDATE users SET caps_balance = 0;")
    rename_column :users, :caps_balance, :caps_cents
  end

  def down
    rename_column :users, :caps_cents, :caps_balance
    ApplicationRecord.connection.execute("UPDATE users SET caps_balance = caps_balance / 100;")
  end
end
