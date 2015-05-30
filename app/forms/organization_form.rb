class OrganizationForm < ApplicationForm
  def self.policy_class
    OrganizationPolicy
  end

  property :name
  property :description

  include AddressForm
end
