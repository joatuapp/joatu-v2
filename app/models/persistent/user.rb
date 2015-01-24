class Persistent::User < Persistent::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  has_many :offers
  has_one :profile

  def name
    if profile.present?
      "#{profile.given_name} #{profile.surname}".strip
    end
  end
end
