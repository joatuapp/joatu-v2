class Pod < ActiveRecord::Base
  has_one :hub

  has_many :pod_memberships
  has_many :members, class: User, through: :pod_memberships
end
