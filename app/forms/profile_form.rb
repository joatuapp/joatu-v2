class ProfileForm < ApplicationForm
  def self.policy_class
    ProfilePolicy
  end

  property :given_name
  property :surname
  property :about_me
  property :user_id, writeable: false
end
