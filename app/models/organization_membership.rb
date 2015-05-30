class OrganizationMembership < Base
  belongs_to :organization
  belongs_to :user

  ORG_MEMBERSHIP_TYPES = {
    admin: 'admin',
    member: 'member',
  }

  validates_each :membership_types do |record, attr, val|
    if val.empty?
      record.errors.add(attr, "cannot be empty")
    end

    val.each do |membership_type|
      unless ORG_MEMBERSHIP_TYPES.values.include? membership_type
        record.errors.add(attr, "contains membership type #{membership_type}, which is invalid")
        break
      end
    end
  end

  def self.where_user_is_member(user)
    where(user: Just(user)).where("'#{ORG_MEMBERSHIP_TYPES[:member]}' = ANY(membership_types)")
  end
  
  def self.where_user_is_admin(user)
    where(user: Just(user)).where("'#{ORG_MEMBERSHIP_TYPES[:admin]}' = ANY(membership_types)")
  end
end
