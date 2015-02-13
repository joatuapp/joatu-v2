class User < Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, # # Commenting registerable to make it invite only.
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_messageable

  has_many :offers
  has_one :profile

  has_one :home_pod, through: :pod_membership, source: :pod
  has_one :pod_membership

  has_many :written_references, class: Reference, foreign_key: :from_user_id
  has_many :received_references, class: Reference, foreign_key: :to_user_id

  validates_acceptance_of :tou_agreement, message: I18n.t('tou.form.error_message')

  before_save :write_preferences

  def name
    if profile.present? && (profile.given_name.present? || profile.surname.present?)
      "#{profile.given_name} #{profile.surname}".strip
    else
      "<anon>"
    end
  end

  def preferences
    @preferences ||= User::Preferences.new(super)
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

  def write_preferences
    write_attribute(:preferences, preferences.to_json)
  end
end
