class RequestForm < OfferOrRequestForm
  def self.policy_class
    RequestPolicy
  end

  property :detail_type, validates: {inclusion: { in: Request.valid_types } }
end
