class AddPodIdToOffersAndRequests < ActiveRecord::Migration
  def change
    change_table :offers_and_requests do |t|
      t.integer :pod_id
    end

    add_foreign_key :offers_and_requests, :pods
  end
end
