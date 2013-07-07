ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'database_cleaner'
require 'dm-transactions'
require 'debugger'

RSpec.configure do |config|
  
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

module SpecHelpers
  
end