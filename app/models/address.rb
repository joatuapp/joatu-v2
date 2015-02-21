class Address
  include Virtus.model

  attribute :address1, String
  attribute :address2, String
  attribute :city, String
  attribute :province, String
  attribute :country, String
  attribute :postal_code, String

  def to_s
    address = [address1, address2].compact.join(" ").strip
    locale = [city, province, country].compact.join(", ").strip

    "#{address} #{locale} #{postal_code}"
  end
end
