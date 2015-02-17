UncreatedPod = Naught.build do |config|
  config.impersonate Pod
  config.black_hole

  def name
    "Uncreated Pod"
  end

  def description
    "There aren't enough JoatU'ers in your area to form a Pod yet, but stay tuned! As more people join the site there's sure to be a Pod opening up in your neighbourhood soon!"
  end

  # Supports using this as an existing value for a select input:
  def to_a
    []
  end
end

class UncreatedPod
  def self.policy_class
    PodPolicy
  end
end
