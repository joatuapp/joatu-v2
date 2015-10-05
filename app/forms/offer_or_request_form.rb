class OfferOrRequestForm < ApplicationForm

  property :title, validates: {presence: true}
  property :description
  property :detail_type

  property :organization_id
  property :organization_privacy

  def organization_privacy=(val)
    super val.to_sym
  end
end
