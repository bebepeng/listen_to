require 'spec_helper'

describe User do
  describe 'validation' do
    it 'requires a unique username' do
      create_valid_user
      user = User.new(:username => 'Bebe')
      user.valid?

      expect(user.errors[:username].length).to eq 1
    end
    it 'requires at lest 8 characters in their password' do
      user = User.new(:password => 'bebe')
      user.valid?

      expect(user.errors[:password].length).to eq 1
    end
  end

  def create_valid_user
    User.create!(:username => 'Bebe', :password => 'password')
  end
end