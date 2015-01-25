class Persistent::CommunityMembership < Persistent::Base
  belongs_to :user
  belongs_to :community
end
