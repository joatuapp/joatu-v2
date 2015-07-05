# Subclass for Offers that are assigned to a specific Organization. Such Offers
# will be visible only to the members and/or admins of the associated
# Organization.
class OrganizationOffer < Offer
  include OrgOfferOrRequest
end
