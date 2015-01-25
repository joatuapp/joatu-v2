class User < DomainModel
  attribute :name
  attribute :email

  association :offers, :Offer
  association :profile, :Profile
  association :mailbox, :Mailbox

  collection :communities, :Community
end
