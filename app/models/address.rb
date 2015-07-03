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
  alias :empty? :blank?

  def save; end

  # This type class allows us to use Address objects as attributes on 
  # ActiveRecord models. This class handles typecasting to/from
  # the DB representation (a JSON column)
  class Type < ActiveRecord::Type::Value
    include ::ActiveRecord::Type::Mutable

    def type
      :json
    end

    def type_cast_from_user(value)
      Address(value)
    end

    def type_cast_from_database(value)
      case value
      when String
        decoded = ::ActiveSupport::JSON.decode(value) rescue nil
        Address(decoded)
      when nil
        # When we load a nil from the DB, replace it with an empty instance
        # of Address, so that we always provide a consistent interface:
        Address(nil)
      else
        super
      end
    end

    def type_cast_for_database(value)
      case value
      when Address
        # If all address attributes are empty, store it in the DB as nil to
        # save storage space.
        if value.empty?
          super(nil)
        else
          ::ActiveSupport::JSON.encode(value)
        end
      when Array, Hash
        ::ActiveSupport::JSON.encode(value)
      else
        super
      end
    end
  end
end

# Method named after the class to handle typecasting to
# Address, similar to the String() Array() etc methods.
def Address(attrs_or_obj)
  case attrs_or_obj
  when Address
    attrs_or_obj
  else
    Address.new(attrs_or_obj)
  end
end
