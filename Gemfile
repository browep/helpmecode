source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
group :development do
	gem 'sqlite3'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem "bcrypt-ruby", :require => "bcrypt"


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

gem 'execjs'
gem 'therubyracer'

gem "nifty-generators", :group => :development
gem "mocha", :group => :test
gem "gravatar-ultimate"

gem "aws-s3"

gem "acts-as-taggable-on"
gem 'rails3-jquery-autocomplete'

group :production do
  gem "mysql2"
end

gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'
gem 'omniauth-openid', :git => 'git://github.com/intridea/omniauth-openid.git'
gem 'omniauth-windowslive', :git => 'git://github.com/joel/omniauth-windowslive.git'

gem 'mongrel'

gem 'omniauth-facebook'

gem "aws-ses", "~> 0.4.4"