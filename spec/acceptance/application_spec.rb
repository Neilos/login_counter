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

  scenario "when logged out" do
    visit '/'
    expect(page).to have_content 'What This Application Does'
  end

  scenario "when logged in"
    # it should show the login count page

end

feature "signing up" do

    # {   username: 'Neil', 
    #     email: 'neil@gmail.com', 
    #     password: 'password')     }

  scenario "valid details are entered" do
    expect(User.all.count).to eql 0
    visit '/'
    click_link 'Sign Up'
    within("#sign_up_form") do
      fill_in 'Username', :with => 'Neil'
      fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'password'
      click_button 'Sign Up'
    end
    expect(page).to have_content "Sign up successful"
    expect(User.all.count).to eql 1
  end
  
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

