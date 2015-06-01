class OfferOrRequestForm < ApplicationForm

  property :title, validates: {presence: true}
  property :description
  property :detail_type
  property :visibility, virtual: true
  property :visible_to_pod, virtual: true
  property :visible_to_orgs, virtual: true

  def visibility=(val)
    super val.to_sym
  end
end
