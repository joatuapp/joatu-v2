class OfferOrRequestForm < ApplicationForm

  property :title, validates: {presence: true}
  property :description
  property :detail_type
  property :visibility
  property :visible_to_pods, writeable: false
  property :visible_to_organizations, writeable: false

  def visibility=(val)
    super val.to_sym
  end

  def save
    super

    if visibility == :private
      model.visible_to_pod_ids = visible_to_pods
      model.visible_to_organization_ids = visible_to_organizations
    end
  end
end
