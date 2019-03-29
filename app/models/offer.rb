class Offer < OfferOrRequest
  default_scope { where(offer_or_request: 'offer') }

  def self.policy_class
    OfferPolicy
  end
end

# This loads the offer subclasses, so that we can call Offer.descendents and
# get all the types.
Dir[Rails.root.join('app', 'models', 'offer', '*.rb')].each {|file| require_dependency file }

