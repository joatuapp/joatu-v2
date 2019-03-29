module Joatu
  class Application
    config.action_mailer.default_url_options = {
      host: ENV.fetch('APP_HOST'),
    }
    config.action_mailer.default_options = {
      from: 'Joatu <info@joatu.org>',
    }
    config.action_mailer.smtp_settings = {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV['SENDGRID_USERNAME'],
      :password       => ENV['SENDGRID_PASSWORD'],
      :domain         => ENV.fetch('APP_HOST'),
      :enable_starttls_auto => true
    }
  end
end
