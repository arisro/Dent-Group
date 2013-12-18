source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'mysql2'
gem 'unicorn'

gem 'bootstrap-sass'

gem 'sass-rails', '~> 4.0.0'
gem 'angularjs-rails', '1.2.0.rc2'
gem 'jquery-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'bourbon'
gem 'simple_form',    '~> 3.0.0'

gem 'roar-rails',     '~> 0.1.4'
gem 'roar',           '~> 0.12.0'

gem 'devise'
gem 'cancan'

group :production do
  gem 'logstasher'
end

group :development do
  gem 'better_errors'
end

group :development, :test do
  gem 'capistrano'
  gem 'capistrano-unicorn', :require => false
  
  gem 'rspec-rails', '~> 2.14'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'jasminerice',  git: 'https://github.com/bradphelan/jasminerice'
  gem 'database_cleaner'
  gem "factory_girl_rails"
  gem 'json_spec'
  gem 'shoulda-matchers', '~> 2.2'
  gem 'faker'
  gem 'simplecov', require: false
  
  gem 'launchy'
  gem 'poltergeist'
  
  gem 'guard'
  gem 'guard-jasmine'
  gem 'guard-rspec'
  
  gem 'rails_layout'
  
  gem 'debugger'
end