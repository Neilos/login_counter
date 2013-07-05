require 'bcrypt'
require 'dm-core'
require 'dm-validations' 
require 'securerandom'

class User
  include BCrypt
  include DataMapper::Resource 

  property :id, Serial
  property :firstname, String, :required => true
  property :lastname, String, :required => true
  property :email, String, :required => true, :unique => true, :format => :email_address
  property :hashed_password, Text, :required => true, :accessor => :private
  property :login_count, Integer, :default => 0, :writer => :private
  property :salt, Text, :required => true, :accessor => :private

  def password
    @password ||= Password.new(self.salt + self.hashed_password)
  end

  def password=(new_password)
    new_salt = make_salt
    self.salt = new_salt
    @password = BCrypt::Password.create(new_salt + new_password, :cost => 11)
    self.hashed_password = @password
  end

  def make_salt
    SecureRandom.hex(30)
  end

  def increment_login_count
    self.login_count = self.login_count + 1
  end

  def correct_password?(entered_password)
    self.password == (salt + entered_password)
  end

end