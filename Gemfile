source 'http://rubygems.org'

gem 'guard'
gem 'guard-rspec'
gem 'rb-inotify', :require => false
gem 'rb-fsevent', :require => false
gem 'rb-fchange', :require => false
gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
gem 'growl' if /darwin/ =~ RUBY_PLATFORM
gem 'database_cleaner', '< 1.1.0' # >= 1.1.0 is broken w/ SQLite3 https://github.com/bmabey/database_cleaner/issues/224
gem 'rspec-rails'
gem 'spork'
gem 'fuubar'
gem 'byebug'
gem 'pry-rails'
gem 'factory_girl_rails'

#gem 'spree', github: 'spree/spree', branch: '3-0-stable'
# Provides basic authentication functionality for testing parts of your engine
#gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'


gemspec
