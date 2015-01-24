class Persistent::Base < ActiveRecord::Base
  self.abstract_class = true

  def self.policy_class
    "#{self.name.split("::").last}Policy".constantize
  end
end
