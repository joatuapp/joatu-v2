class Organization < ActiveRecord::Base
  has_many :memberships, class_name: OrganizationMembership
  has_many :members, through: :memberships, source: :user

  composed_of :address, mapping: %w(address_json to_json)

  # Not strictly necessary to specify the currency is caps here, as the app
  # default is caps, but this keeps things explicit, and doesn't hurt.
  monetize :caps_cents, with_currency: :caps 
end
