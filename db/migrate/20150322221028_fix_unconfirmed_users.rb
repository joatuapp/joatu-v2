class FixUnconfirmedUsers < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("UPDATE users SET confirmed_at = NOW() WHERE confirmed_at IS NULL")
  end

  def down
  end
end
