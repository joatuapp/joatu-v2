class CreatePodsAndOrganizationsAssociations < ActiveRecord::Migration
  def change
    create_join_table :users, :pods, table_name: :pod_memberships do |t|
      t.string :membership_types, array: true, default: []
      t.timestamps null: false
      t.index :membership_types, using: 'gin'
    end
    add_foreign_key :pod_memberships, :users
    add_foreign_key :pod_memberships, :pods

    create_join_table :pods, :organizations, table_name: :pod_organization_relations do |t|
      t.string :type
      t.timestamps null: false
    end
    add_foreign_key :pod_organization_relations, :pods
    add_foreign_key :pod_organization_relations, :organizations
  end
end
