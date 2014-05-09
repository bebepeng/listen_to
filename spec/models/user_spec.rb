require 'spec_helper'

describe User do
  describe 'validation' do
    it 'requires a unique username' do
      create_valid_user
      user = User.new(:username => 'Bebe')
      user.valid?

      expect(user.errors[:username].length).to eq 1
    end

    it 'does not consider case when validating uniqueness of user name' do
      create_valid_user
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
  end

  describe 'finder' do
    it 'finds the user regarless of username case' do
      create_valid_user

      expect(User.find_by_case_insensitive_username('bebe').username).to eq 'Bebe'
    end
  end

  def create_valid_user
    User.create!(:username => 'Bebe', :password => 'password')
  end
end