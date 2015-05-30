module AddressForm
  include Reform::Form::Module

  property :address do
    property :name
    property :address1
    property :address2
    property :city
    property :province
    property :country
    property :postal_code
  end
end
