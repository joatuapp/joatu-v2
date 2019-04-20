class UserForm < ApplicationForm
  def self.policy_class
    UserPolicy
  end

  property :email
  property :password
  property :password_confirmation

  def password=(val)
    super unless val.nil?
  end

  def password_confirmation=(val)
    super unless val.nil?
  end
end
