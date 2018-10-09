source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
gem 'rails', '~> 5.2.1'

gem 'aws-sdk-s3'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cloudinary'
gem 'fastimage'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-health'
gem 'ruby-filemagic'

group :development do
  gem 'byebug', group: :test
  gem 'dotenv-rails', group: :test
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker', group: :development
  gem 'factory_bot_rails', group: :development
  gem 'rspec-rails', group: :development
end
