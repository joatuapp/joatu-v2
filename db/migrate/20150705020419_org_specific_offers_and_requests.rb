class OrgSpecificOffersAndRequests < ActiveRecord::Migration
  def change
    change_table :offers_and_requests do |t|
      t.remove :visibility
      t.rename :user_id, :created_by_user_id
      t.rename :organization_id, :created_by_organization_id
      t.integer :organization_id
    end

    add_foreign_key :offers_and_requests, :organizations

    drop_table :offer_and_request_access_controls
  end
end
