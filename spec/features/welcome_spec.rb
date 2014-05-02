require 'spec_helper'

feature 'Welcome page' do
  scenario 'User gets greeted by the Welcome page' do
    visit root_path
    expect(page).to have_content "Welcome! :D"
    expect(page).to have_content "Listen to what Bebe Listens to."

    click_on 'Click here for more.'
    expect(page).to have_content "Songs List"
  end
end