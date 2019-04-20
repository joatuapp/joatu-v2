AnonymousProfile = Naught.build do |config|
  config.impersonate Profile
  config.black_hole

  def id
    nil
  end

  def full_name
    "Anonymous"
  end

  def to_s
    full_name
  end

  # Supports using this as an existing value for a select input:
  def to_a
    []
  end
end

class AnonymousProfile
  def self.policy_class
    ProfilePolicy
  end
end
