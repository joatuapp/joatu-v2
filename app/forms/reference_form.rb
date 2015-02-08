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
  property :to_user_id, validates: {presence: true}

  # Writeable is false because the form NEVER sets the 'from' user. It can read
  # it for validation purposes (see #not_refrencing_self method)
  property :from_user_id, writeable: false, validates: {presence: true}

  validates_uniqueness_of :to_user_id, scope: :from_user_id
  validate :not_referencing_self

  private

  def not_referencing_self
    errors[:base] = "Cannot leave a reference for yourself!" if to_user_id == from_user_id
  end
end
