# This class is a singleton and represents the source of all Caps. We "create"
# caps by creating a caps transaction transfering points from this object to
# another object (user, organization, etc).

class CapsGenerator
  include Singleton

  # Required to match AR interface, so this can be set as a polymorphic
  # relation.
  def self.primary_key
    :id
  end

  # Required to match AR interface, so this can be set as a polymorphic
  # relation.
  def self.base_class
    self
  end

  # Required to match AR interface, so this can be set as a polymorphic
  # relation.
  def [](val)
    if val == :id
      1
    end
  end

  def caps_cents
    Float::INFINITY
  end

  def caps_cents=(val)
    # No-op
  end
end
