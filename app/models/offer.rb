class Offer < Base
  belongs_to :user

  def self.owned_by(user, pagination)
    where(user_id: user.id).paginate(pagination)
  end

  def self.available_to(user, pagination)
    includes(user: [:profile]).paginate(pagination)
  end

  def self.search_results(search_data, user, pagination)
    where("title LIKE ?", "#{search_data[:search]}%").available_to(user, pagination)
  end
end
