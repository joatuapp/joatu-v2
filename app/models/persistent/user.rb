class Persistent::User < Persistent::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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

  # Over-ride for devise asking it to use ActionMailer's "deliver later"
  # feature, so that emails will be queued when we configure a queueing
  # service.
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
