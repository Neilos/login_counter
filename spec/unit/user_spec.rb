ENV['RACK_ENV'] = 'test'

require 'rspec'
require_relative '../../lib/models/DM_config'

describe User do
  
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

  let(:valid_user) do
    User.new(
      username: 'Neil', 
      email: 'neil@gmail.com', 
      password: 'password')
  end

  let(:invalid_email_user) do
    User.new(username: 'Neil', email: 'neilatgmaildotcom', password: 'password')
  end

  describe "new user" do

    it "can be saved to the database" do
      expect(User.all.count).to eql 0
      valid_user.save
      expect(User.all.count).to eql 1
    end

    context "when first created" do
      it "should have a login_count of 0" do
        valid_user.save
        expect(valid_user.login_count).to eql 0 
      end

      it "should have a 60 character salt" do
        expect(valid_user.send(:salt).length).to eql 60
      end
    end

    context "with a non-unique email" do
      it "wont be valid (and so wont save to the database)" do
        expect(User.all.count).to eql 0
        duplicate_user = valid_user.dup
        valid_user.save
        expect(User.all.count).to eql 1
        expect(duplicate_user.valid?).to be_false
        duplicate_user.save
        expect(User.all.count).to eql 1
      end
    end

    context "without an email" do
      it "wont be valid (and so wont save to the database)" do
        no_email_user = User.new( 
          username: 'Neil', 
          password: 'password')
        expect(User.all.count).to eql 0
        expect(no_email_user.valid?).to be_false
        no_email_user.save
        expect(User.all.count).to eql 0
      end
    end

    context "with an invalid email" do
      it "wont be valid (and so wont save to the database)" do
        invalid_email_user = User.new(
          username: 'Neil', 
          email: 'neilatgmaildotcom', 
          password: 'password')
        expect(User.all.count).to eql 0
        expect(invalid_email_user.valid?).to be_false
        invalid_email_user.save
        expect(User.all.count).to eql 0
      end
    end

    context "without a name" do
      it "wont be valid (and so wont save to the database)" do
        no_username_user = User.new( 
          email: 'neil@gmail.com', 
          password: 'password')
        expect(User.all.count).to eql 0
        expect(no_username_user.valid?).to be_false
        no_username_user.save
        expect(User.all.count).to eql 0
      end
    end

    context "without a password" do
      it "wont be valid (and so wont save to the database)" do
        no_password_user = User.new( 
          username: 'Neil', 
          email: 'neil@gmail.com')
        expect(User.all.count).to eql 0
        expect(no_password_user.valid?).to be_false
        no_password_user.save
        expect(User.all.count).to eql 0
      end
    end

  end

  describe "existing user" do

    let(:existing_user) do
      user = User.new(
        username: 'Neil', 
        email: 'neil@gmail.com', 
        password: 'password')
      user.save
      user
    end

    context "on demand" do
      it "can increment the count of the number of times a user has logged in" do
        expect(existing_user.login_count).to eql 0
        existing_user.increment_login_count
        expect(existing_user.login_count).to eql 1
      end

      it "knows when a given password is correct" do
        expect(existing_user.correct_password?('password')).to be_true
      end

      it "knows when a given password is incorrect" do
        expect(existing_user.correct_password?('incorrect')).to be_false
      end
    end

  end


end