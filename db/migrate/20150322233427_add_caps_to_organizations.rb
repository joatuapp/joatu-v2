class AddCapsToOrganizations < ActiveRecord::Migration
  def change
    add_monetize :organizations, :caps
  end
end
