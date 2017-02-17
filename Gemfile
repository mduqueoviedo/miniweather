source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Twitter Bootstrap CSS framework
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass'
# angularjs
gem 'angularjs-rails', '~> 1.6.0'
gem 'ng-rails-csrf'

# mongodb access
gem 'kaminari'
gem 'kaminari-mongoid'
gem 'mongoid', '~> 6.0.0'

# application config
gem 'config'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # ruby style checker
  gem 'rubocop', require: false
end

group :test do
  # TDD unit testing
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'rspec-retry'
  gem 'shoulda-matchers'

  # test data fixtures
  gem 'factory_girl_rails'

  # feature tests
  gem 'capybara'
  gem 'capybara-ng'
  gem 'capybara-screenshot'
  gem 'poltergeist'
end
