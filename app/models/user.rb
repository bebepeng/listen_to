
class User < ActiveRecord::Base

  validates :email, :presence => true
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password, :length => {:minimum => 8}, if: 'password.present?'
  has_secure_password

  def self.find_by_case_insensitive_email(email)
    User.find_by('lower(email) = ?', email.downcase)
  end
end
