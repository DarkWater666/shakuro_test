# Gemfile
source 'https://rubygems.org'
ruby '2.5.1'

# application
gem 'sinatra'
gem 'sqlite3'
gem 'sinatra-contrib'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'rake'
gem 'dotenv'

# server
gem 'puma'
gem 'shotgun'

# api builders
gem 'rack-cors', require: 'rack/cors'
gem 'grape'
gem 'grape-entity'

# test
group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'factory_bot'
  gem 'database_cleaner'
end

# debug
group :development do
  gem 'byebug'
  gem 'rails_best_practices'
  gem 'listen'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
end

# guards
group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubycritic', require: false
  gem 'guard', require: false
  gem 'guard-rubocop', require: false
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'guard-shell'
  gem 'guard-rails_best_practices', github: 'logankoester/guard-rails_best_practices'
end

# console
group :console do
  gem 'awesome_print'
  gem 'hirb', github: 'bogdan/hirb', branch: 'render-nils'
end
