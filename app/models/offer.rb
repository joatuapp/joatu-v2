class Offer < Base
  belongs_to :user

  def self.owned_by(user)
    where(user_id: user.id)
  end

  def self.text_search(search)
    where("title LIKE ?", "#{search}%")
  end
end
