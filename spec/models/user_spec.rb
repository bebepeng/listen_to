require 'spec_helper'

describe User do
  describe 'validation' do
    it 'requires a unique email' do
      create_user
      user = User.new(:email => 'bebe@email.com')
      user.valid?

      expect(user.errors[:email].length).to eq 1
    end

    it 'requires a unique username' do
      create_user
      user = User.new(:username => 'Bebe')
      user.valid?

      expect(user.errors[:username].length).to eq 1
    end

    it 'does not consider case when validating uniqueness of user name' do
      create_user
      user = User.new(:username => 'bebe')
      user.valid?

      expect(user.errors[:username].length).to eq 1
    end

    it 'requires at lest 8 characters in their password' do
      user = User.new(:password => 'bebepen')
      user.valid?

      expect(user.errors[:password].length).to eq 1

      user = User.new(:password => 'bebepeng')
      user.valid?

      expect(user.errors[:password].length).to eq 0
    end

    it 'requires the password and the password_confirmation to match' do
      user = User.new(:password => 'bebepeng', :password_confirmation => 'bebepen')
      user.valid?

      expect(user.errors[:password_confirmation].length).to eq 1
    end
  end

  describe 'finder' do
    it 'finds the user regardless of email case' do
      create_user

      expect(User.find_by_case_insensitive_email('Bebe@email.com').email).to eq 'bebe@email.com'
    end
  end
end