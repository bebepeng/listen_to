require 'spec_helper'

feature 'Welcome page' do
  scenario 'User gets greeted by the Welcome page' do
    visit '/'
    expect(page).to have_content "Welcome! :D"
    expect(page).to have_content "Listen to what Bebe Listens to."
  end
end