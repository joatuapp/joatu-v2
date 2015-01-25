class Community < DomainModel
  attribute :name

  collection :members, :User
end
