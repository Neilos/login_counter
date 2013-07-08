require_relative '../spec_helpers'
require 'capybara/rspec'
require 'selenium-webdriver'
require_relative '../../lib/models/DM_config'
require_relative '../../lib/controllers/application_controller'

Capybara.app = ApplicationController


feature "Visitor visits home page", :js => true   do

  scenario "when logged out" do
    visit '/'
    expect(page).to have_content 'What This Application Does'
  end

  scenario "when logged in"do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link('Log in')
    within("#formLogin") do
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button('Log In')
    end
    page.should have_css('#loginCount')
    page.should have_content("Currently logged in.")
    visit '/'
    expect(page).to have_content("Currently logged in.")
  end

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

feature "Visitor logs in", :js => true do
  
  scenario "for the FIRST time with correct credentials" do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link 'Log in'
    within("#formLogin") do
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button('Log In')
    end
    page.should have_css('#loginCount')
    page.should have_content("Currently logged in.")
    page.should have_content("Login count since sign up: 1")
  end

  scenario "for the SECOND time with correct credentials" do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link 'Log in'
    within("#formLogin") do
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button('Log In')
    end
    page.should have_css('#loginCount')
    page.should have_content("Currently logged in.")
    page.should have_content("Login count since sign up: 1")
    
    click_link('Log out')

    click_link 'Log in'
    within("#formLogin") do
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button('Log In')
    end
    page.should have_css('#loginCount')
    page.should have_content("Currently logged in.")
    page.should have_content("Login count since sign up: 2")

  end

  scenario "with invalid email" do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link('Log in')
    within("#formLogin") do
      fill_in 'Email', :with => 'invalidemail'
      fill_in 'Password', :with => 'password'
      click_button('Log In')
    end
    page.should have_css('#loginErrors')
    page.should have_content("Email and/or password are not recognized. Please try again")
    page.should_not have_content("Currently logged in.")
  end

  scenario "with wrong password" do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link('Log in')
    within("#formLogin") do
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'wrongpassword'
      click_button('Log In')
    end
    page.should have_css('#loginErrors')
    page.should have_content("Email and/or password are not recognized. Please try again")
    page.should_not have_content("Currently logged in.")
  end

  
end

feature "Visitor logs out", :js => true do

  before(:each) do
    User.create(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
    visit '/'
    click_link('Log in')
    within("#formLogin") do
      fill_in 'Email', :with => 'neil@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button('Log In')
    end
  end

  scenario "when logged in" do
    
    page.should have_css('#loginCount')
    page.should have_content("Currently logged in.")
    click_link('Log out')
    expect(page).to have_content 'Home Page'
    expect(page).to have_content 'What This Application Does'
  end

  scenario "and tries to access logged in page again" do

    click_link('Log out')
    visit '/logged_in'
    expect(page).to have_content 'Home Page'
    expect(page).to have_content 'What This Application Does'
  end

end

