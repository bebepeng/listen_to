require 'spec_helper'

feature 'User Sessions' do
  scenario 'users can log out' do
    visit '/'
    click_on 'Register'
    fill_in 'Email', :with => 'bebe@email.com'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Register'

    click_on 'Log Out'
    expect(page).to have_no_content "Welcome, Bebe!"
    expect(page).to have_link "Register"

  end

  scenario 'users can login' do
    create_valid_user

    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => 'bebe@email.com'
    fill_in 'Password', :with => 'password'
    click_on 'Log In'

    expect(page).to have_content "Welcome, Bebe!"
    expect(page).to have_no_link "Log In"
  end

  scenario 'users cannot login with invalid password' do
    create_valid_user

    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => 'bebe@email.com'
    fill_in 'Password', :with => 'stuffthatisstuff'
    click_on 'Log In'

    expect(page).to have_no_content "Welcome, Bebe!"
    expect(page).to have_content "Invalid Username or Password"
  end

  scenario 'users cannot login with a non-existent user' do
    create_valid_user

    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => 'stuff@stuff.com'
    fill_in 'Password', :with => 'stuffthatisstuff'
    click_on 'Log In'

    expect(page).to have_no_content "Welcome, Bebe!"
    expect(page).to have_content "Invalid Username or Password"
  end
end