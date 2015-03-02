class Request < OfferOrRequest
  default_scope { where(offer_or_request: 'request') }
end
