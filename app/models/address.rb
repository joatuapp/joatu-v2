class Address
  include ActiveModel::Model
  include Virtus.model

  attribute :name, String
  attribute :address1, String
  attribute :address2, String
  attribute :city, String
  attribute :province, String
  attribute :country, String
  attribute :postal_code, String

  def to_s
    address = [address1, address2].compact.join(" ").strip
    locale = [city, province, country].compact.join(", ").strip

    addr_string = "#{name} #{address} #{locale} #{postal_code}".strip
    addr_string.empty? ? "Address: Empty" : "Address: #{addr_string}"
  end

  def blank?
    attributes.all? {|k,v| v.blank? }
  end

  def save; end
end
