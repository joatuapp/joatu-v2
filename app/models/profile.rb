class Profile < ApplicationRecord
  has_one :user
  validates :given_name,
            presence: true

  validates :surname,
            presence: true

  def self.available_to(user, pagination)
    paginate(pagination)
  end

  def full_name
    name = "#{given_name} #{surname}".strip
    name.blank? ? "anonymous" : name
  end
end
