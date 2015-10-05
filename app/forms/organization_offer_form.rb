class OrganizationOfferForm < OfferForm
  # def self.policy_class
    # OrganizationOfferPolicy
  # end
  
  property :created_by_organization_id, validates: {presence: true}
end
