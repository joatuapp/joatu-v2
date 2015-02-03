class RequestSearchForm < ApplicationForm
  property :search, empty: true
  property :order_by, empty: true, type: Symbol

  validates :search, presence: true
  validates :order_by, inclusion: {in: [nil, :title, :created_at]}
end
