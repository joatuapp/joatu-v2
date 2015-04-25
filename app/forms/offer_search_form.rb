class OfferSearchForm < ApplicationForm
  property :search, empty: true
  property :order_by, empty: true, type: Symbol, default: :created_at_desc
  property :types_filter, empty: true, type: Array, default: Offer.valid_types

  def types_filter= (val)
    val = Array(val)
    val.reject! {|v| v.blank? }
    super
  end

  validates :order_by, inclusion: {in: [nil, :created_at_desc, :created_at_asc]}
  validate :types_filter_valid

  private 
  
  def types_filter_valid
    valid_types = Offer.valid_types

    types_filter.each do |type|
      unless valid_types.include? type
        errors.add(:types_filter, "is invalid. Offer type #{type} not recognized.")
      end
    end
  end
end
