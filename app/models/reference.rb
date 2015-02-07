class Reference < ActiveRecord::Base
  include Paginatable
  acts_as_paranoid

  belongs_to :to_user, class: User
  belongs_to :from_user, class: User
  belongs_to :offer

  validates :to_user, uniqueness: {scope: :from_user}

  def self.to_user(user, pagination)
    where(to_user_id: user.id).paginate(pagination)
  end
end
