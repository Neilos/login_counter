ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'
require 'dm-transactions'

require_relative '../../lib/models/DM_config'
require_relative '../spec_helpers'
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


feature "visiting the home page" do

  scenario "when logged out"
    # it should explain what the app does
    # it should have a login form
    # it should have a signup form

  scenario "when logged in"
    # it should show the login count page

end

feature "signing up" do
  
  scenario "with invalid email"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "with email already used"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "when password doesn't match password confirmation"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "when password is not of the correct length"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "valid details are entered"
    # it should add the user to the database
    # it should confirm the signup
    # it wont show the signup form

end

feature "logging in" do
  
  scenario "with invalid email"
    # it should display an appropriate error message
    # it wont log the user in

  scenario "with wrong password"
    # it should display an appropriate error message
    # it wont log the user in

  scenario "with correct details"
    # it should show the login count page

end

feature "logging out" do

  scenario "when logged in"
    # it should show the home page

end

