class AddOrganizationPrivacyToOffersAndRequests < ActiveRecord::Migration
  def change
    add_column :offers_and_requests, :organization_privacy, :string, default: "all", null: true
  end
end
