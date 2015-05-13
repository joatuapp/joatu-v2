class PendingCommunityOfferForm < ApplicationForm
  property :name, validates: {presence: true}
  property :description, validates: {presence: true}
  property :starts_at, type: DateTime, validates: {presence: true}
  property :ends_at, type: DateTime, validates: {presence: true}

  property :capacity, type: Integer
  property :status, type: String, default: 'pending_approval'

  property :address do
    property :location_name, type: String, from: :name, validates: {presence: true}
    property :address1, type: String, validates: {presence: true}
    property :address2, type: String
    property :city, type: String, validates: {presence: true}
    property :province, type: String, validates: {presence: true}
    property :country, type: String, validates: {presence: true}
    property :postal_code, type: String, validates: {presence: true}
  end

  property :details, from: :community_offer_detail do
    property :value_to_society, type: String
    property :producer_qualifications, type: String
    property :estimated_hours_of_work, type: Integer
    property :requirements_provided, type: String
    property :requirements_requested, type: String
    property :requests, type: String
    property :question_or_comment, type: String
  end

  property :creator, validates: {presence: true}
  property :organization
  property :pod

  def creator_id=(val)
    self.creator = User.find(val)
  end

  def organization_id=(val)
    self.organization = Organization.find(val)
  end
end
