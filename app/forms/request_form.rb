class RequestForm < ApplicationForm
  def self.policy_class
    RequestPolicy
  end

  property :title, validates: {presence: true}
  property :description
  property :type, validates: {inclusion: { in: Request.valid_types } }
end
