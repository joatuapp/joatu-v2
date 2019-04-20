class OfferForm < ApplicationForm
  def self.policy_class
    OfferPolicy
  end

  property :title, validates: {presence: true}
  property :description, validates: {presence: true}
  property :type, validates: {presence: true, inclusion: { in: Offer.valid_types } }
  property :visibility, virtual: true

  def visibility
    if model.new_record? || model.pod_id.present?
      :pod
    else
      :global
    end
  end

  def visibility=(val)
    super val.to_sym
  end
end
