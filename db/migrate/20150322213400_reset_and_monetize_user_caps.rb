class ResetAndMonetizeUserCaps < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("UPDATE users SET caps_balance = 0;")
    rename_column :users, :caps_balance, :caps_cents
  end

  def down
    rename_column :users, :caps_cents, :caps_balance
    ActiveRecord::Base.connection.execute("UPDATE users SET caps_balance = caps_balance / 100;")
  end
end
