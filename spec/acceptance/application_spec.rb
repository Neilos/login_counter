ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
# require 'selenium-webdriver'
# require 'capybara-webkit'
require 'database_cleaner'
require 'dm-transactions'

require_relative '../../lib/models/DM_config'
require_relative '../spec_helpers'
require_relative '../../lib/controllers/application_controller'

# # Use the webkit javascript driver
# Capybara.javascript_driver = :webkit

# Set the application to be used by capybara
Capybara.app = ApplicationController

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

feature "Visitor visits home page", :js => true do

  scenario "when logged out" do
    visit '/'
    expect(page).to have_content 'What This Application Does'
  end

  scenario "when logged in"
    # it should show the login count page

end

feature "Visitor signs up", :js => true do

  scenario "with valid details" do
    page.driver.options[:resynchronize] = false
    expect(User.all.count).to eql 0
    visit '/'
    click_link 'Sign up'
    within("#signup_form") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'password'
      # find('#buttonSignup').click
      click_button('Sign Up')
    end
    puts "#{page.html.inspect}"
    page.should have_css('#success_messages', :visible => true)
    within('#messages') do
      page.should have_content("Sign up successful!")
    end
    # expect(page).to have_content "Sign up successful!"
  end
  
  scenario "with invalid email"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "with email already used"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "with a password doesn't match the password confirmation"
    # it should display an appropriate error message
    # it wont sign up the user

  scenario "without password of the wrong length"
    # it should display an appropriate error message
    # it wont sign up the user

end

feature "Visitor logs in" do
  
  scenario "with invalid email"
    # it should display an appropriate error message
    # it wont log the user in

  scenario "with wrong password"
    # it should display an appropriate error message
    # it wont log the user in

  scenario "with correct details"
    # it should show the login count page

end

feature "Visitor logs out" do

  scenario "when logged in"
    # it should show the home page

end

