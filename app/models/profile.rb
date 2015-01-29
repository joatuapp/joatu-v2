class Profile < Base
  belongs_to :user

  def self.available_to(user, pagination)
    paginate(pagination)
  end
end
