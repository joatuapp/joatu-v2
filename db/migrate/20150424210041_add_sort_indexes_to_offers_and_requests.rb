class AddSortIndexesToOffersAndRequests < ActiveRecord::Migration
  def up
    remove_index :offers_and_requests, :offer_or_request
    remove_index :offers_and_requests, :type

    add_index :offers_and_requests, [:offer_or_request, :pod_id, :created_at], name: 'collection_select_index'
    add_index :offers_and_requests, [:type, :pod_id, :created_at], name: 'type_collection_select_index'
  end

  def down
    remove_index :offers_and_requests, [:offer_or_request, :pod_id, :created_at], name: 'collection_select_index'
    remove_index :offers_and_requests, [:type, :pod_id, :created_at], name: 'type_collection_select_index'

    add_index :offers_and_requests, :offer_or_request
    add_index :offers_and_requests, :type
  end
end
