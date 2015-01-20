class OfferForm < Reform::Form
  property :title, validates: {presence: true}
  property :summary
  property :description
  property :user_id, validates: {presence: true}
end
