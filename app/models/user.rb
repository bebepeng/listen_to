require 'bcrypt'

class User < ActiveRecord::Base
  validates_uniqueness_of :username
  validates :password, :length => {:minimum => 8}
  has_secure_password
end
