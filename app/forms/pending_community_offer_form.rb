class PendingCommunityOfferForm < ApplicationForm
  property :name
  property :description
  property :starts_at, type: DateTime
  property :ends_at, type: DateTime

  property :capacity, type: Integer
  property :status, type: String, default: 'pending_approval'

  property :address do
    property :location_name, type: String, from: :name
    property :address1, type: String
    property :address2, type: String
    property :city, type: String
    property :province, type: String
    property :country, type: String
    property :postal_code, type: String
  end

  property :details, from: :community_offer_detail do
    property :value_to_society, type: String
    property :producer_qualifications, type: String
    property :estimated_hours_of_work, type: Integer
    property :requirements_provided, type: String
    property :requirements_requested, type: String
    property :requests, type: String
  end

  property :creator
  property :organization
  property :pod

  def creator_id=(val)
    self.creator = User.find(val)
  end

  def organization_id=(val)
    self.organization = Organization.find(val)
  end
end
