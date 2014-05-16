require 'spec_helper'

feature 'Users' do

  scenario 'users can Register' do
    visit '/'
    click_on 'Register'
    fill_in 'Email', :with => 'bebe@email.com'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Register'

    expect(page).to have_content "Listen to What Bebe"
    expect(page).to have_content "Welcome, Bebe!"
  end

  scenario 'users see errors when they fail' do
    create_valid_user

    visit '/'
    click_on 'Register'
    fill_in 'Email', :with => 'bebe@email.com'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Register'

    expect(page).to have_content "Username has already been taken"
    expect(page).to have_content "Email has already been taken"
  end

  scenario 'users can edit themselves' do
    create_valid_user

    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => 'bebe@email.com'
    fill_in 'Password', :with => 'password'
    click_on 'Log In'
    click_on 'settings'
    expect(page).to have_content "bebe@email.com"
    expect(page).to have_content "Bebe"
    click_on 'Edit Account'

    fill_in 'Username', :with => 'BebePeng'
    click_on 'Save Changes'
    expect(page).to have_content "Listen to What BebePeng"
  end

  scenario 'users can delete their accounts'

  def create_valid_user
    User.create!(:email => 'bebe@email.com', :username => 'Bebe', :password => 'password')
  end
end