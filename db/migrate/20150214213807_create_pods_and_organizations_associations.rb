class CreatePodsAndOrganizationsAssociations < ActiveRecord::Migration
  def change
    create_table :pod_memberships do |t|
      t.integer :pod_id, null: false
      t.integer :user_id, null: false
      t.string :membership_types, array: true, default: []
      t.timestamps null: false
      t.index :membership_types, using: 'gin'
      t.index [:pod_id, :user_id], unique: true
    end
    add_foreign_key :pod_memberships, :users
    add_foreign_key :pod_memberships, :pods

    create_table :pod_organization_relations do |t|
      t.integer :pod_id, null: false
      t.integer :organization_id, null: false
      t.string :type
      t.timestamps null: false
    end
    add_foreign_key :pod_organization_relations, :pods
    add_foreign_key :pod_organization_relations, :organizations
  end
end
