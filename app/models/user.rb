require 'bcrypt'

class User < ActiveRecord::Base
  validates_uniqueness_of :username, :case_sensitive => false
  validates :password, :length => {:minimum => 8}
  has_secure_password

  def self.find_by_case_insensitive_username(username)
    User.find_by('lower(username) = ?', username.downcase)
  end
end
