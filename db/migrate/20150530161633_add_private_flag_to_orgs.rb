class AddPrivateFlagToOrgs < ActiveRecord::Migration
  def change
    add_column :organizations, :is_private, :boolean, default: false
  end
end
