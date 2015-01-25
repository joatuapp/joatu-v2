class Persistent::User < Persistent::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  has_many :offers
  has_one :profile
  has_many :community_memberships
  has_many :communities, through: :community_memberships

  def name
    if profile.present? && (profile.given_name.present? || profile.surname.present?)
      "#{profile.given_name} #{profile.surname}".strip
    else
      "<anon>"
    end
  end
end
