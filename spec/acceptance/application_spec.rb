ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'
require_relative '../../lib/controllers/application_controller'

# Configure rspec
RSpec.configure do |c|
  c.before(:each) do
    DatabaseCleaner.start
  end

  c.after(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end

# Set the application to be used by capybara
Capybara.app = ApplicationController

describe "the application", :type => :feature do
  
  describe "when...", :type => :feature  do

    it "should..."

  end

end

