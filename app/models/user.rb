class User < DomainModel
  attribute :email
  attribute :offers, DomainModel.attr_type(:Offer)
  attribute :profile, DomainModel.attr_type(:Profile)
  attribute :mailbox
end
