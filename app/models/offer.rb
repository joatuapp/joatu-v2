class Offer < OfferOrRequest
  default_scope { where(offer_or_request: 'offer') }
end
