require 'rails_helper'

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

Capybara.asset_host = 'http://localhost:3000'
Capybara::Screenshot.prune_strategy = { keep: 10 }

include Warden::Test::Helpers
Warden.test_mode!
