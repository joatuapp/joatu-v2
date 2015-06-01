class OfferOrRequestAccessControl < Base
  self.table_name = "offer_and_request_access_controls"

  belongs_to :offer_or_request
  belongs_to :group, polymorphic: true

  validates_presence_of :offer_or_request_id
  validates_presence_of :group_id

  validates :grant_or_deny, inclusion: { in: %w(grant deny) }
end
