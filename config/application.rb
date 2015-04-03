require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# require "rails/test_unit/railtie"

# Enable garbage collector profiling for newrelic:
GC::Profiler.enable

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JoatuV2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = ['en-CA', 'fr-CA', :en, :fr]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Include errors dir in autolaod
    config.autoload_paths += %W(#{config.root}/lib/errors)
    config.autoload_paths += %W(#{config.root}/app/services/concerns)

    # TODO: Using sql schema due to bugs in the (beta) postgres activerecord adapter.
    # Once a stable version is released we should be able to remve this and
    # regenerate the schema in Ruby format.
    config.active_record.schema_format = :sql
  end
end
