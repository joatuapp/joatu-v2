class User < Base
  NullObject = Naught.build
  include NullObject::Conversions

  HOME_POD_TYPE = 'home_pod'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, # # Commenting registerable to make it invite only.
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  acts_as_messageable

  has_many :offers
  has_one :profile

  has_one :home_pod, through: :home_pod_membership, source: :pod
  has_one :home_pod_membership, -> { where("'#{HOME_POD_TYPE}' = ANY(membership_types)") }, class: PodMembership

  has_many :written_references, class: Reference, foreign_key: :from_user_id
  has_many :received_references, class: Reference, foreign_key: :to_user_id
  
  after_validation :retrieve_home_pod, on: :create, if: ->(u){ Actual(u.home_pod).blank? }
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

  def home_pod_id
    home_pod.id
  end

  def home_pod_id=(val)
    self.home_pod = Pod.find_by_id(val)
  end

  def home_pod
    super || UncreatedPod.new
  end

  def home_pod=(new_home_pod)
    new_home_pod = Actual(new_home_pod)
    return if new_home_pod.blank?

    if home_pod_membership
      home_pod_membership.pod = new_home_pod
    else
      self.build_home_pod_membership(pod: new_home_pod, membership_types: [HOME_POD_TYPE]).pod
    end
  end

  private


  def retrieve_home_pod
    self.home_pod = Pod.best_for_user(self)
  end

  def write_preferences
    write_attribute(:preferences, preferences.to_json)
  end
end
