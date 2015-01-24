class Profile < DomainModel
  attribute :user, DomainModel.attr_type(:User)
  attribute :given_name
  attribute :surname
  attribute :about_me
end
