class DropRequests < ActiveRecord::Migration
  def up
    drop_table :requests
  end
end
