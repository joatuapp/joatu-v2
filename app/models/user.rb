class User < Base
  include Wisper::Publisher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, # # Commenting registerable to make it invite only.
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_messageable

  # Not strictly necessary to specify the currency is caps here, as the app
  # default is caps, but this keeps things explicit, and doesn't hurt.
  monetize :caps_cents, with_currency: :caps 

  attribute :preferences, User::Preferences::Type.new, default: User::Preferences.new
  
  has_one :profile

  before_validation :update_home_location, if: :postal_code_changed?
  after_save :publish_location_updated, if: :home_location_changed?

  def profile
    super || AnonymousProfile.new
  end

  def name
    profile.full_name
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

  def guest?
    false
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
