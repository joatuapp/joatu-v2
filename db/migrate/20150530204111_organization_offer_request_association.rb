class OrganizationOfferRequestAssociation < ActiveRecord::Migration
  def change
    add_column :offers_and_requests, :organization_id, :integer
    add_foreign_key :offers_and_requests, :organizations, on_delete: :cascade
  end
end
