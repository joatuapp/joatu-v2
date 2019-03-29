class Request < OfferOrRequest
  default_scope { where(offer_or_request: 'request') }

  def self.policy_class
    RequestPolicy
  end
end

# This loads the request subclasses, so that we can call Request.descendents and
# get all the types.
Dir[Rails.root.join('app', 'models', 'request', '*.rb')].each {|file| require_dependency file }

