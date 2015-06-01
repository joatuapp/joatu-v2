class OfferAndRequestPrivacy < ActiveRecord::Migration
  def change
    add_column :offers_and_requests, :visibility, :string

    create_table :offer_and_request_access_controls do |t|
      t.integer :offer_or_request_id, null: false
      t.references :group, polymorphic: true, null: false
      t.string :grant_or_deny, default: "grant", null: false
    end

    add_index :offer_and_request_access_controls, [:offer_or_request_id, :group_id, :group_type], unique: true, name: "unique_index_on_offer_and_group"
    add_foreign_key :offer_and_request_access_controls, :offers_and_requests, column: :offer_or_request_id
  end
end
