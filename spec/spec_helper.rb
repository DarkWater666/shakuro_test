ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
require 'dotenv/load'
require 'byebug'
require 'factory_bot'
require 'database_cleaner'
require 'sinatra'
require 'sinatra/activerecord'
require 'rspec'
require 'rack/test'
require_relative '../config/application.rb'

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

Dir['./spec/support/custom_matchers/**/*.rb'].each { |f| require f }

def body_as_json
  json_str_to_hash(last_response.body)
end

def json_str_to_hash(str)
  JSON.parse(str).with_indifferent_access
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
