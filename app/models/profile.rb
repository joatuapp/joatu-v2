class Profile < ApplicationRecord
  belongs_to :user

  def self.available_to(user, pagination)
    paginate(pagination)
  end

  def full_name
    name = "#{given_name} #{surname}".strip
    name.blank? ? "anonymous" : name
  end
end
