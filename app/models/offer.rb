class Offer < DomainModel
  association :user, :User
  attribute :title
  attribute :summary
  attribute :description
end
