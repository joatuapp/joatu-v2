class Request < OfferOrRequest
  default_scope { where(offer_or_request: 'request') }

  def self.policy_class
    RequestPolicy
  end
end
