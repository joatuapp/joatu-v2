class Offer < OfferOrRequest
  default_scope { where(offer_or_request: 'offer') }

  def self.policy_class
    OfferPolicy
  end
end
