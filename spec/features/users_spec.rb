require 'spec_helper'

feature 'Users' do

  scenario 'users can Register' do
    visit '/'
    click_on 'Register'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Register'

    expect(page).to have_content "Bebe's page"
    expect(page).to have_content "Welcome, Bebe!"
  end

  scenario 'users see errors when they fail' do
    create_valid_user

    visit '/'
    click_on 'Register'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Register'

    expect(page).to have_content "Username has already been taken"
  end

  scenario 'users can log out' do
    visit '/'
    click_on 'Register'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Register'

    click_on 'Log Out'
    expect(page).to have_no_content "Welcome, Bebe!"
    expect(page).to have_link "Register"

  end

  scenario 'users can login'
  scenario 'users can delete their accounts'

  def create_valid_user
    User.create!(:username => 'Bebe', :password => 'password')
  end
end