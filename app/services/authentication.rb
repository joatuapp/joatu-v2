class Authentication
  Config = Struct.new(:warden, :user)

  def self.build
    config = Config.new
    yield(config)

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
    !user.is_a?(GuestUser)
  end
end
