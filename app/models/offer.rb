class Offer < DomainModel
  attribute :user, DomainModel.attr_type(:User)
  attribute :title
  attribute :summary
  attribute :description
end
