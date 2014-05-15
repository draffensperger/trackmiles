source 'https://rubygems.org'

#ruby '2.0.0'
#ruby '1.9.3'

gem 'rails', '~>4.0.0'
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'figaro'
gem 'rest-client'
gem 'versionist'
gem 'kramdown'
gem 'tzinfo'
gem 'tzinfo-data'
gem 'sidekiq'
gem 'sidekiq-unique-jobs'
gem 'geocoder'
gem 'activerecord-import', '~>0.4.1'
gem 'gon'
gem 'http_logger'

gem 'sass-rails'
gem 'coffee-rails'
gem 'coffee-script-source', '1.5.0'
gem 'uglifier'

gem 'rails_12factor'

# I like to be able to test and benchmark different servers and platforms. 
gem 'pg', :platforms => :ruby
gem 'activerecord-jdbcpostgresql-adapter', :platforms => :jruby 
gem 'puma'  
gem 'thin', :platforms => :ruby
gem 'unicorn', :platforms => :ruby

gem 'newrelic_rpm'
  
group :development, :test do
  gem 'execjs', :platforms => :ruby
  
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rspec-rails' 
  
  gem 'test-unit'
  
  gem 'libv8', :platforms => :ruby  
  gem 'therubyracer', :platforms => :ruby 
end

group :test do
  gem 'webmock'
  gem 'rspec-autotest'
  gem 'spork-rails', :git => 'git://github.com/sporkrb/spork-rails.git'
  gem 'guard-spork' 
end