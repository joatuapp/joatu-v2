class CreateCommunityOfferDetails < ActiveRecord::Migration
  def change
    create_table :community_offer_details do |t|
      t.integer :event_id
      t.text :value_to_society
      t.text :producer_qualifications
      t.integer :estimated_hours_of_work
      t.text :requirements_provided
      t.text :requirements_requested
      t.text :requests
    end

    add_foreign_key :community_offer_details, :events, on_delete: :cascade
  end
end
