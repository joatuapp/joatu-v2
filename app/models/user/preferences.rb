class User::Preferences
  include Virtus.model

  attribute :locale, String, default: I18n.default_locale

  def locale=(val)
    # Cannot set locale to nil, should fall back on default in that case:
    super unless val.nil?
    val # Return val for consistency
  end
end
