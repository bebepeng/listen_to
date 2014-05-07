require 'spec_helper'

feature 'Users' do
  scenario 'users can sign up, but not twice' do
    visit '/'
    click_on 'Sign Up'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Sign Up'

    expect(page).to have_content "Bebe's page"
    expect(page).to have_content "Welcome, Bebe!"
    expect(page).to have_link "Log Out"
    expect(page).to_not have_link "Sign Up"

    click_on 'Log Out'
    click_on 'Sign Up'
    fill_in 'Username', :with => 'Bebe'
    fill_in 'Password', :with => 'password'
    click_on 'Sign Up'

    expect(page).to have_content "Username has already been taken"
  end
  scenario 'users can login'
  scenario 'users can delete their accounts'
end