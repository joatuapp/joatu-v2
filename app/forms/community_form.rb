class CommunityForm < ApplicationForm
  def self.policy_class
    CommunityPolicy
  end

  property :name, validates: {presence: true}
end
