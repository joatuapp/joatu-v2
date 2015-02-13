class PodsAndHubsAssociations < ActiveRecord::Migration
  def change
    create_join_table :users, :pods, table_name: :pod_memberships do |t|
      t.timestamps null: false
    end

    add_reference :hubs, :pod, index: true
  end
end
