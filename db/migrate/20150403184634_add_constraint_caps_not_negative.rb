class AddConstraintCapsNotNegative < ActiveRecord::Migration
  def up
    execute "ALTER TABLE caps_transactions ADD CONSTRAINT check_caps_cents CHECK (caps_cents >= 0)" 
    execute "ALTER TABLE organizations ADD CONSTRAINT check_caps_cents CHECK (caps_cents >= 0)" 
    execute "ALTER TABLE users ADD CONSTRAINT check_caps_cents CHECK (caps_cents >= 0)" 
  end

  def down
    execute "ALTER TABLE caps_transactions DROP CONSTRAINT check_caps_cents" 
    execute "ALTER TABLE organizations DROP CONSTRAINT check_caps_cents"
    execute "ALTER TABLE users DROP CONSTRAINT check_caps_cents" 
  end
end
