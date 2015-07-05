# This concern provides relations, validations, and shared
# functionality to OrganizationOffer and OrganizationRequest models to keep
# code DRY:
module OrgOfferOrRequest
  extend ActiveSupport::Concern

  included do
    belongs_to :organization

    validates_presence_of :organization_id
  end
end
