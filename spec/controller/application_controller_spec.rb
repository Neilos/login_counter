require_relative '../spec_helpers'
require_relative '../../lib/models/DM_config'
require_relative '../../lib/controllers/application_controller'

def app
  ApplicationController.new
end

describe ApplicationController do

  describe "visiting the home page" do

    context "when NOT logged in" do
      it "should show the home page" do
        get '/'
        expect(last_response.ok?).to eql true
        expect(last_response.body.include?('Home Page')).to eql true
        expect(last_response.body.include?('What This Application Does')).to eql true
      end
    end

    context "when logged in" do
      it "should redirect to the logged in page" 
    end

  end

  describe "signup" do

    context "when signup is succesful" do

      let(:submitted_data) do
        { :firstname => 'Simon',
          :lastname => 'Jones',
          :email => 'simon@gmail.com',
          :password => 'password'}
      end

      it "should return a success message" do
        post '/signup', params = submitted_data
        expect(last_response.ok?).to eql true
        expect(last_response.body.include?("Sign up successful!")).to eql true
      end

      it "should add user to the database" do
        expect(User.all.count).to eql 0
        post '/signup', params = submitted_data
        expect(User.all.count).to eql 1
      end

    end

  end

  describe "login" do

    before(:each) do
      @signed_up_user = User.create(
        :firstname => 'Simon',
        :lastname => 'Jones',
        :email => 'simon@gmail.com',
        :password => 'password')
    end

    context "when credentials are correct" do

      let(:valid_login_data) do
          { :email => @signed_up_user.email,
            :password => 'password' }
      end

      it "should increment the login count" do
        expect(@signed_up_user.login_count).to eql 0
        post '/login', params = valid_login_data
        logged_in_user = User.first
        expect(logged_in_user.login_count).to eql 1
      end

    end

    context "when login email is unknown" do

      let(:unknown_email_data) do
          { :email => 'unknownemail',
            :password => 'password' }
      end

      it "wont increment the login count" do
        expect(@signed_up_user.login_count).to eql 0
        post '/login', params = unknown_email_data
        logged_in_user = User.first
        expect(logged_in_user.login_count).to eql 0
      end

    end

    context "when login password is incorrect" do

      let(:incorrect_password_data) do
          { :email => @signed_up_user.email,
            :password => 'unknownpassword' }
      end

      it "wont increment the login count" do
        expect(@signed_up_user.login_count).to eql 0
        post '/login', params = incorrect_password_data
        logged_in_user = User.first
        expect(logged_in_user.login_count).to eql 0
      end

    end

  end

end