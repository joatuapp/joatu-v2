class OfferForm < Reform::Form
  def self.policy_class
    OfferPolicy
  end

  property :title, validates: {presence: true}
  property :summary
  property :description
  property :user_id, validates: {presence: true}
end
