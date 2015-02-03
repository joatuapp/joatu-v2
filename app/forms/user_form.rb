class UserForm < ApplicationForm
  def self.policy_class
    UserPolicy
  end

  property :email
end
