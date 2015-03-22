class AddCapsToOrganizations < ActiveRecord::Migration
  def change
    add_monetize :organizations, :caps_cents
  end
end
