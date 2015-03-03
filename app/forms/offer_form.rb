class OfferForm < ApplicationForm
  def self.policy_class
    OfferPolicy
  end

  property :title, validates: {presence: true}
  property :description
  property :type, validates: {inclusion: { in: Offer.valid_types } }
  property :visibility, virtual: true

  def visibility
    super || :pod
  end

  def visibility=(val)
    super val.to_sym
  end
end
