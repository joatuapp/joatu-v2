UncreatedPod = Naught.build do |config|
  config.impersonate Pod
  config.black_hole

  def id
    nil
  end

  def name
    "Uncreated Pod"
  end

  def description
    "Oops! You have selected a postal code without a designated pod. Please email info@joatu.com with the postal code that you entered and we'll fix the problem for you as soon as possible."
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
