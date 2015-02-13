class Users::SessionsController < Devise::SessionsController

  # Don't set locale from the param till after we've created the session:
  skip_before_action :set_locale, only: :create

  def create
    super do |user|
      # On successful sign in, force a rebuild of our Authentication singleton
      # with the new state:
      Authentication.rebuild! do |config|
        config.warden = request.env["warden"]
      end
      
      # If the locale parameter is set to the default locale, do NOT use it,
      # which will cause set_locale to fall back on the logged in user's saved
      # locale. This means if your saved language is french but you're browsing
      # the home page in English, when you sign in, you'll start seeing French.
      # If you're browsing the home page in Italian before you sign in,
      # however, you'll still see italian _after_ signing in.
      if params[:locale] == I18n.default_locale.to_s
        params[:locale] = nil
      end
      set_locale
    end
  end

  def destroy
    super do
      # On successful termination of the devise session, force a rebuild of our
      # Authentication singleton with the new state!
      Authentication.rebuild! do |config|
        config.warden = request.env["warden"]
      end
    end
  end
end
