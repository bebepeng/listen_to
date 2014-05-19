require 'spec_helper'

feature 'User accounts' do
  feature 'guests' do
    scenario 'guests can Register' do
      visit '/'
      click_on 'Register'
      fill_in 'Email', :with => 'bebe@email.com'
      fill_in 'Username', :with => 'Bebe'
      fill_in 'Password', :with => 'password'
      click_on 'Register'

      expect(page).to have_content "Listen to What Bebe"
      expect(page).to have_content "Welcome, Bebe!"
    end

    scenario 'guests see errors when they fail to register' do
      create_user

      visit '/'
      click_on 'Register'
      fill_in 'Email', :with => 'bebe@email.com'
      fill_in 'Username', :with => 'Bebe'
      fill_in 'Password', :with => 'password'
      click_on 'Register'

      expect(page).to have_content "Username has already been taken"
      expect(page).to have_content "Email has already been taken"
    end
  end

  feature 'users' do
    before do
      login(create_user)
    end

    scenario 'users cannot register' do
      expect(page).to have_no_link 'Register'
      visit new_user_path
      expect(page).to have_no_button 'Register'
    end

    scenario 'users can edit themselves' do
      click_on 'settings'
      expect(page).to have_content "bebe@email.com"
      expect(page).to have_content "Bebe"
      click_on 'Edit Account'

      fill_in 'Username', :with => 'BebePeng'
      click_on 'Save Changes'
      expect(page).to have_content "Listen to What BebePeng"
    end

    scenario 'users can delete their accounts'
  end
end
