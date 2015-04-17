module JoatuV2
  class Application
    config.action_mailer.default_url_options = {host: ENV.fetch('APP_HOST')}

    config.action_mailer.smtp_settings = {
      address: "smtp.mandrillapp.com",
      port: 587,
      enable_starttls_auto: true,
      user_name: ENV.fetch("MANDRILL_USERNAME"),
      password: ENV.fetch("MANDRILL_PASSWORD"),
      authentication: :login,
      domain: ENV.fetch('APP_HOST'),
    }
  end
end

MANDRILL = Mandrill::API.new ENV['MANDRILL_PASSWORD']
