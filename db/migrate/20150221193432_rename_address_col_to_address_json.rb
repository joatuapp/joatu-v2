class RenameAddressColToAddressJson < ActiveRecord::Migration
  def change
    rename_column :organizations, :address, :address_json
    rename_column :events, :address, :address_json
  end
end
