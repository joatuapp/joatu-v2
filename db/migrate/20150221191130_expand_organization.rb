class ExpandOrganization < ActiveRecord::Migration
  def change
    change_table :organizations do |t|
      t.json :address
    end

    create_table :organization_memberships do |t|
      t.integer :organization_id, null: false
      t.integer :user_id, null: false
      t.string :membership_types, array: true, default: []
      t.timestamps null: false
      t.index :membership_types, using: 'gin'
      t.index [:organization_id, :user_id], unique: true
    end

    add_foreign_key :organization_memberships, :users
    add_foreign_key :organization_memberships, :organizations
  end
end
