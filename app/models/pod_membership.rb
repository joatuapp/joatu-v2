class PodMembership < ApplicationRecord
  belongs_to :user
  belongs_to :pod

  POD_MEMBERSHIP_TYPES = {
    home: 'home_pod',
  }

  def self.home_membership_for_user(user)
    membership = where(user_id: user.id).where("'#{POD_MEMBERSHIP_TYPES[:home]}' = ANY(membership_types)").first_or_initialize
    # Required because rails won't be able to figure out that we want to
    # initilize the object with membership_type = [home_pod]
    # automatically:
    membership.membership_types << POD_MEMBERSHIP_TYPES[:home] if membership.new_record?
    membership
  end
end
