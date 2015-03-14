DeletedUser = Naught.build do |config|
  config.mimic example: User.new

  def name
    "<deleted>"
  end

  def preferences
    # Deleted users have a real preferences object, which since guests are never
    # persisted will always just use defaults.
    @preferences ||= User::Preferences.new
  end
end
