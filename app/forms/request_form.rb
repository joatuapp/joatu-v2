class RequestForm < ApplicationForm
  def self.policy_class
    RequestPolicy
  end

  property :title, validates: {presence: true}
  property :description
end
