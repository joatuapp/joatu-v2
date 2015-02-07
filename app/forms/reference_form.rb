class ReferenceForm < ApplicationForm
  def self.policy_class
    ReferencePolicy
  end

  property :reference, validates: {presence: true}
  property :rating, type: Integer, validates: {
    presence: true, 
    inclusion: {in: 1..5}
  }

  property :offer_id
  property :to_user_id
end
