source 'https://rubygems.org'

ruby ">=2.4.1"

gem 'rails', '~> 4.0'

gem 'rack-attack'

group :development, :test do
  gem "minitest"
  gem "minitest-reporters"
  gem "minitest-rails", "~> 2.0"
  gem 'pry'
  gem 'pry-byebug', :platforms => [ :mri_20, :mri_21, :mri_22 ]
end

gem 'web-console', '~> 2.0', :group => :development

gem 'protected_attributes'
gem 'json', '~> 2.0'
gem 'haml'
gem 'haml-rails'
gem 'therubyracer'
gem 'ezcrypto', :git => 'https://github.com/pglombardo/ezcrypto.git'
gem 'modernizr-rails', :git => 'https://github.com/russfrisch/modernizr-rails.git'
gem "high_voltage"

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

gem 'foreman'
gem 'unicorn'
gem 'jquery-rails'
gem 'pg', '~> 0.21'

group :production do
end

group :private do
  gem "sqlite3", '< 1.4.0'
end
