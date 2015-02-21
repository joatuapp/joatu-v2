class Organization < ActiveRecord::Base
  has_many :memberships, class: OrganizationMembership
  has_many :members, through: :memberships, source: :user

  composed_of :address, mapping: %w(address_json to_json)
end
