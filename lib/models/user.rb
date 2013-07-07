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
  attr_reader :password
  validates_presence_of :password
  validates_with_method :password, :validate_password

  def validate_password
    return true if self.password && (8..32) === self.password.length
    [false, "Password must be between 8 and 32 characters long"]
  end

  def password=(new_password)
    @password = "X" * new_password.length if new_password  # store a string of the same length as the password
    new_salt = make_salt
    self.salt = new_salt
    self.hashed_password = BCrypt::Password.create(new_salt + new_password)
  end

  def make_salt
    SecureRandom.hex(30)
  end

  def increment_login_count
    self.login_count = login_count + 1
  end

  def authenticated?(entered_password)
    BCrypt::Password.new(hashed_password) == (salt + entered_password)
  end

  def full_name
    firstname + ' ' + lastname
  end

end