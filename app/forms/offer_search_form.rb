class OfferSearchForm < ApplicationForm
  property :search, empty: true
  property :order_by, empty: true, type: Symbol

  validates :order_by, inclusion: {in: [:title, :created_at]}
end
