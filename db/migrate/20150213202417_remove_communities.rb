class RemoveCommunities < ActiveRecord::Migration
  def change
    drop_table :communities
    drop_table :community_memberships
  end
end
