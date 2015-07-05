# Subclass for Requests that are assigned to a specific Organization. Such Requests
# will be visible only to the members and/or admins of the associated
# Organization.
class OrganizationRequest < Request
  include OrgOfferOrRequest
end
