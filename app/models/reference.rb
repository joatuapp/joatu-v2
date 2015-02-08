class Reference < ActiveRecord::Base
  include Paginatable
  acts_as_paranoid

  belongs_to :to_user, class: User
  belongs_to :from_user, class: User
  belongs_to :offer

  def self.to_user(user, pagination)
    where(to_user_id: user.id).paginate(pagination)
  end

  def reciprocal
    self.class.where(to_user: from_user, from_user: to_user).take
  end
end
