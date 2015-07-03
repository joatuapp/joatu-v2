class User::Preferences
  include Virtus.model

  attribute :locale, String, default: I18n.default_locale

  def locale=(val)
    # Cannot set locale to nil, should fall back on default in that case:
    super unless val.nil?
    val # Return val for consistency
  end

  def blank?
    attributes.all? {|k,v| v.blank? }
  end
  alias :empty? :blank?

  # This type class allows us to use User::Preference objects as attributes on 
  # ActiveRecord models. This class handles typecasting to/from
  # the DB representation (a JSON column)
  class Type < ActiveRecord::Type::Value
    include ::ActiveRecord::Type::Mutable

    def type
      :json
    end

    def type_cast_from_user(value)
      UserPreferences(value)
    end

    def type_cast_from_database(value)
      case value
      when String
        decoded = ::ActiveSupport::JSON.decode(value) rescue nil
        UserPreferences(decoded)
      when nil
        # Keep a consistent interface, return an empty preferences
        # object even if DB value is nil:
        UserPreferences(nil)
      else
        super
      end
    end

    def type_cast_for_database(value)
      case value
      when User::Preferences
        # If User::Preferences object is empty store it as a simple nil value
        # rather than a long JSON string, to save storage space:
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
# User::Prefernces, similar to the String() Array() etc methods.
def UserPreferences(attrs_or_obj)
  case attrs_or_obj
  when User::Preferences
    attrs_or_obj
  else
    User::Preferences.new(attrs_or_obj)
  end
end
