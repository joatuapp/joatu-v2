# Guest user is a Null object that is based off an instance of User.
# This means it should respond to all the same methods, including
# dynamic column accessors, but also still raise appropraite errors for
# misspelled method names, etc (it doesn't just blanket-respond to
# everything.
#
# We can further cusomize this class as needed by simply defining other
# methods within the build block. For more, see the documentation for
# Naught: https://github.com/avdi/naught
GuestUser = Naught.build do |config|
  config.mimic example: User.new

  def preferences
    # Guest users have a real preferences object, which since guests are never
    # persisted will always just use defaults.
    @preferences ||= User::Preferences.new
  end

  def signed_in?
    false
  end
end
