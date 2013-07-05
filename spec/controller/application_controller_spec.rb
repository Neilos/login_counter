ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner'

require_relative '../../lib/controllers/application_controller'

# Configure rspec
RSpec.configure do |c|
  c.include Rack::Test::Methods

  c.before(:each) do
    DatabaseCleaner.start
  end

  c.after(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end

# Set the app to be used by sinatra
def app
  ApplicationController.new
end

describe ApplicationController do

  it "should..."

end