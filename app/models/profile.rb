class Profile < DomainModel
  association :user, :User
  attribute :given_name
  attribute :surname
  attribute :about_me
end
