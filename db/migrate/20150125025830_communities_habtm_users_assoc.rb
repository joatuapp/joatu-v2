class CommunitiesHabtmUsersAssoc < ActiveRecord::Migration
  def change
    create_join_table :communities, :users, table_name: :community_memberships do |t|
      t.index :community_id
      t.index :user_id
    end
  end
end
