class Authentication
  Config = Struct.new(:warden, :user)
  def self.instance_or_build
    @auth ||= begin
      config = Config.new
      yield(config)
      self.build(config)
   end
  end

  def self.rebuild!(&block)
    @auth = nil
    instance_or_build(&block)
  end

  def self.build(config)
    if config.warden
      config.user = config.warden.authenticate(scope: :user)
    end
    new(config)
  end

  def initialize(config)
    config.user ||= GuestUser.new
    @user = config.user
  end

  def user
    @user
  end

  def user_signed_in?
    out = !user.is_a?(GuestUser)
    Rails.logger.debug "User: #{user} signed in? #{out.inspect}"
    out
  end

  private_class_method :new
end
