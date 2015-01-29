class Community < Base
  has_many :community_memberships
  has_many :members, through: :community_memberships, class_name: "User"
end
