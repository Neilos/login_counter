ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'database_cleaner'
require 'dm-transactions'

require_relative '../spec_helpers.rb'
require_relative '../../lib/models/DM_config'
require_relative '../spec_helpers'
require_relative '../../lib/controllers/application_controller'

# Set the application to be used by capybara
Capybara.app = ApplicationController


feature "Visitor visits home page"do

  scenario "when logged out" do
    visit '/'
    expect(page).to have_content 'What This Application Does'
  end

  scenario "when logged in"
    # it should show the login count page

end

feature "Visitor signs up", :js => true do

  scenario "with valid details" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_no_css('#signupErrors')
    page.should have_content("Sign up successful!")
  end
  
  scenario "with blank FIRST name field" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      # fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Firstname must not be blank")
  end
  
  scenario "with blank LAST name field" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      # fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Lastname must not be blank")
  end
  
  scenario "with blank EMAIL field" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      # fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Email must not be blank")
  end
  
  scenario "with invalid EMAIL" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neilatexampledotcom'
      fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Email has an invalid format")
  end

  scenario "with EMAIL already taken" do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Email is already taken")
  end

  scenario "with blank PASSWORD field" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@example.com'
      # fill_in 'Password', :with => 'password'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Password must not be blank")
  end

  scenario "when PASSWORD is too short" do
    visit '/'
    click_link 'Sign up'
    within("#formSignup") do
      fill_in 'First Name', :with => 'Neil'
      fill_in 'Last Name', :with => 'Atkins'
      fill_in 'Email', :with => 'neil@example.com'
      fill_in 'Password', :with => 'short'
      click_button('Sign Up')
    end
    page.should have_css('#signupErrors')
    page.should have_content("Password must be between 8 and 32 characters long")
  end

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

