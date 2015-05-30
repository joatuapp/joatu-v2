class Organization < Base
  has_many :memberships, class: OrganizationMembership
  has_many :members, through: :memberships, source: :user

  composed_of :address, mapping: %w(address_json to_json)

  before_validation :serialize_address

  # Not strictly necessary to specify the currency is caps here, as the app
  # default is caps, but this keeps things explicit, and doesn't hurt.
  monetize :caps_cents, with_currency: :caps 

  # Returns the collection of organizations that are either public
  # (visible to all JoatUers) _or_ of which the given user is a
  # member.
  def self.public_or_member_of(user)
    membership_of_ids = OrganizationMembership.where_user_is_member(user).pluck(:organization_id)

    if membership_of_ids.empty?
      where(is_private: false)
    else
      where("is_private = FALSE OR id IN(#{membership_of_ids.join(',')})")
    end
  end

  # Returns a boolean result of whether the given user is an admin of this
  # organization:
  def user_is_admin?(user)
    memberships.where_user_is_admin(user).any?
  end

  def has_member?(user)
    memberships.where(user: user).any?
  end

  def private?
    is_private?
  end

  private

  def serialize_address
    self.address_json = address.to_json
  end
end
