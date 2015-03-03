class OfferForm < ApplicationForm
  def self.policy_class
    OfferPolicy
  end

  property :title, validates: {presence: true}
  property :description
  property :type, validates: {presence: true, inclusion: { in: Offer.valid_types } }
  property :visibility, virtual: true

  def visibility
    if model.new_record?
      :pod
    else
      model.pod_id.present? ? :pod : :global
    end
  end

  def visibility=(val)
    super val.to_sym
  end
end
