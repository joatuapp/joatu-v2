class OfferForm < OfferOrRequestForm
  def self.policy_class
    OfferPolicy
  end

  property :detail_type, validates: {presence: true, inclusion: { in: Offer.valid_detail_types } }
end
