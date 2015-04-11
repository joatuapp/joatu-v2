# This class is a singleton and represents the source of all Caps. We "create"
# caps by creating a caps transaction transfering points from this object to
# another object (user, organization, etc).

class CapsGenerator
  include Singleton
  include FakeArModel

  def name
    "Caps Generator"
  end

  # NOTE: These caps & caps_cents accessors are basically all null-operations,
  # but cause this class to behave like it has a caps balance than can be added
  # to & subtracted from, just like other objects. The catch here is that the
  # CapsGenerator will never run out of caps.
  def caps_cents
    100_000_000_000 # A really big, constant number.
  end
  
  def caps
    Money.new(caps_cents, "CAPS")
  end

  def caps_cents=(val)
    # No-op
  end
  alias caps= caps_cents=
end
