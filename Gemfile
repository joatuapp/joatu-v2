source 'https://rubygems.org'

gem 'dotenv-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'pg_search'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-cookie-rails'
gem 'jquery-turbolinks'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'paranoia'

# Mailboxer, handle messaging between users
gem 'mailboxer', github: 'div/mailboxer', branch: 'rails42-foreigner'
gem 'kaminari'

# Rails frontend specific gems:
gem 'simple_form', '~> 3.1.0'

# Use puma as the app server
gem 'puma'

gem 'newrelic_rpm'

gem 'i18n-tasks', '~> 0.7.11'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master'

gem 'activeadmin', github: 'activeadmin'

# Use action caching to cache the home page and alpha_signup page,
# both of which are static, to improve performance.
gem 'actionpack-action_caching'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Protects mail from going out to the real world in all environments for which
# this gem is installed:
gem "mail_safe", group: [:development, :staging]

gem 'foreman', '~> 0.75'
gem 'bootstrap-sass', '~> 3.3.1'
gem 'autoprefixer-rails'
gem 'devise', '~> 3.4.1'
gem 'devise_invitable', '~> 1.4.0'
gem 'pundit', '~> 0.3.0'
gem 'use_case', '~> 1.0.2'
gem 'reform', '~> 1.2.5'
gem 'virtus', '~> 1.0.4'
gem 'haml-rails', '~> 0.7.0'
gem 'bootstrap-sass-extras', '~> 0.0.6'
gem "font-awesome-rails"
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'spring-commands-rspec'
  gem 'pry-rails'
end
