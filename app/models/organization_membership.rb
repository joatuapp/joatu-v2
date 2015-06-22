class OrganizationMembership < Base
  belongs_to :organization
  belongs_to :user

  ORG_MEMBERSHIP_TYPES = {
    admin: 'admin',
  }

  validates_each :membership_types do |record, attr, val|
    val.each do |membership_type|
      unless ORG_MEMBERSHIP_TYPES.values.include? membership_type
        record.errors.add(attr, "contains membership type #{membership_type}, which is invalid")
        break
      end
    end
  end

  # Membership is defined simply by a record for the given user existing
  # in the table:
  def self.where_user_is_member(user)
    where(user: Just(user))
  end
  
  # Admin status requires a specific membership_type value:
  def self.where_user_is_admin(user)
    where(user: Just(user)).where("'#{ORG_MEMBERSHIP_TYPES[:admin]}' = ANY(membership_types)")
  end

  def self.user_is_org_admin?(user)
    where_user_is_admin(user).any?
  end
end
