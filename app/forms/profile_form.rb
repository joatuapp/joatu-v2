class ProfileForm < ApplicationForm
  def self.policy_class
    ProfilePolicy
  end

  property :given_name
  property :surname
  property :about_me
  property :accepted_currencies

  def accepted_currencies=(val)
    super val.reject{|v| v.empty? }
  end
end
