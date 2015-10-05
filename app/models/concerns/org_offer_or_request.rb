# This concern provides relations, validations, and shared
# functionality to OrganizationOffer and OrganizationRequest models to keep
# code DRY:
module OrgOfferOrRequest
  extend ActiveSupport::Concern

  included do
    belongs_to :created_by_organization, class_name: "Organization"
    validates_presence_of :created_by_organization_id
  end

  def created_by
    if created_by_organization_id.present?
      created_by_organization
    else
      created_by_user
    end
  end
end
