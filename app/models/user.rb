class User < Base
  include Wisper::Publisher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, # # Commenting registerable to make it invite only.
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_messageable

  composed_of :preferences, class_name: "User::Preferences", mapping: %w(preferences_json to_json)
  
  has_one :profile

  after_save :publish_location_updated, if: :postal_code_changed?

  def name
    "<anon>"
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

  private
  
  def publish_location_updated
    broadcast(:user_location_updated, self)
  end
end
