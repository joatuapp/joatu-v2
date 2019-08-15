class User < ApplicationRecord
  include Wisper::Publisher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_messageable

  # Not strictly necessary to specify the currency is caps here, as the app
  # default is caps, but this keeps things explicit, and doesn't hurt.
  monetize :caps_cents, with_currency: :caps

  composed_of :preferences, class_name: "User::Preferences", mapping: %w(preferences_json to_json)

  has_one :profile
  has_one :pod_membership
  has_one :pod, through: :pod_membership

  has_many :offers
  has_many :requests

  before_validation :update_home_location, if: :postal_code_changed?
  after_save :publish_location_updated, if: :home_location_changed?

  def profile
    super || Profile.new
  end

  def name
    profile.full_name
  end

  def first_name
    profile.given_name
  end

  def last_name
    profile.surname
  end

  def first_name=(arg)
    profile.given_name = arg
  end

  def last_name=(arg)
    profile.surname = arg
  end

  # Return false if we should not send an email for 'object_to_send' otherwise,
  # return the email address to send to:
  def mailboxer_email(object_to_send)
    email
  end

  # Over-ride for devise asking it to use ActionMailer's "deliver later"
  # feature, so that emails will be queued when we configure a queueing
  # service.
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def is_admin?
    is_admin
  end

  def pod_id
    pod.id if pod
  end

  def pod_id=(arg)
    if arg.present?
      self.pod = Pod.find arg
    else
      self.pod = nil
    end
  end

  def pod
    super || UncreatedPod.new
  end

  private

  def update_home_location
    lat,lng = Geocoder.coordinates(self.postal_code)
    self.home_location = "POINT(#{lng} #{lat})"
  end

  def publish_location_updated
    broadcast(:user_location_updated, self)
  end
end
