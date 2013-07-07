require_relative '../spec_helpers'
require_relative '../../lib/models/DM_config'

describe User do

  let(:valid_user) do
    User.new(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neil@gmail.com', 
      password: 'password')
  end

  let(:invalid_email_user) do
    User.new(
      firstname: 'Neil', 
      lastname: 'Atkins', 
      email: 'neilatgmaildotcom', 
      password: 'password')
  end

  it "can be saved to the database if valid" do
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

  it "has a log in count that can be incremented" do
    expect(valid_user.login_count).to eql 0
    valid_user.increment_login_count
    expect(valid_user.login_count).to eql 1
  end

  it "has a full_name" do
    expect(valid_user.full_name).to eql 'Neil Atkins'
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
        firstname: 'Neil', 
        lastname: 'Atkins',
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
        firstname: 'Neil', 
        lastname: 'Atkins',
        email: 'neilatgmaildotcom', 
        password: 'password')
      expect(User.all.count).to eql 0
      expect(invalid_email_user.valid?).to be_false
      invalid_email_user.save
      expect(User.all.count).to eql 0
    end
  end

  context "without a first name" do
    it "wont be valid (and so wont save to the database)" do
      no_first_name_user = User.new( 
        lastname: 'Atkins',
        email: 'neil@gmail.com', 
        password: 'password')
      expect(User.all.count).to eql 0
      expect(no_first_name_user.valid?).to be_false
      no_first_name_user.save
      expect(User.all.count).to eql 0
    end
  end

  context "without a last name" do
    it "wont be valid (and so wont save to the database)" do
      no_last_name_user = User.new( 
        firstname: 'Atkins',
        email: 'neil@gmail.com', 
        password: 'password')
      expect(User.all.count).to eql 0
      expect(no_last_name_user.valid?).to be_false
      no_last_name_user.save
      expect(User.all.count).to eql 0
    end
  end

  context "without a password" do
    it "wont be valid (and so wont save to the database)" do
      no_password_user = User.new( 
        firstname: 'Neil', 
        lastname: 'Atkins',
        email: 'neil@gmail.com')
      expect(User.all.count).to eql 0
      expect(no_password_user.valid?).to be_false
      no_password_user.save
      expect(User.all.count).to eql 0
    end
  end

  describe "authenticatation" do

    let(:existing_user) do
      User.create(
        firstname: 'Neil', 
        lastname: 'Atkins', 
        email: 'neil@gmail.com', 
        password: 'password')
    end
    
    context "when a correct password is given" do
      it "is authenticated" do
        expect(existing_user.authenticated?('password')).to be_true
      end
    end

    context "when an INVALID password is given" do
      it "is NOT authenticated" do
        expect(existing_user.authenticated?('unknownpassword')).to be_false
      end
    end

  end

end