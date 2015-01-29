class CommunityMembership < Base
  belongs_to :user
  belongs_to :community
end
