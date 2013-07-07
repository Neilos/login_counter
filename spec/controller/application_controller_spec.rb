ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner'
require_relative '../spec_helpers.rb'
require_relative '../../lib/models/DM_config'

require_relative '../../lib/controllers/application_controller'



# Set the app to be used by sinatra
def app
  ApplicationController.new
end

describe ApplicationController do

  describe "signup" do
    context "when signup is succesful"
    it "should return a success message" do
      submitted_data = {
        :firstname => 'Simon',
        :lastname => 'Jones',
        :email => 'simon@gmail.com',
        :password => 'password'}
      post '/signup', params = submitted_data
      expect(last_response.body.include?("Sign up successful!")).to eql true
      expect(last_response.ok?).to eql true
    end

    it "should add user to the database" do
      submitted_data = {
        :firstname => 'Simon',
        :lastname => 'Jones',
        :email => 'simon@gmail.com',
        :password => 'password'}
      expect(User.all.count).to eql 0
      post '/signup', params = submitted_data
      expect(User.all.count).to eql 1
    end
  end


end