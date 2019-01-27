class Request < OfferOrRequest
  default_scope { where(offer_or_request: 'request') }

  def self.policy_class
    RequestPolicy
  end

  def self.valid_types
    descendants.map {|c| c.name }
  end

  def self.type_options
    descendants.inject({}) do |h, c|
      h[I18n.t("offers_and_requests.types.#{c.name.demodulize.underscore}")] = c.name.to_s

      h
    end
  end
end

# This loads the request subclasses, so that we can call Request.descendents and
# get all the types.
Dir[Rails.root.join('app', 'models', 'request', '*.rb')].each {|file| require_dependency file }

