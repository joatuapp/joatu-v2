class PodsAndHubsAssociations < ActiveRecord::Migration
  def change
    create_join_table :users, :pods, table_name: :pod_memberships do |t|
      t.timestamps null: false
    end
    add_foreign_key :pod_memberships, :users
    add_foreign_key :pod_memberships, :pods

    add_reference :hubs, :pod, index: false
    add_foreign_key :hubs, :pods
  end
end
