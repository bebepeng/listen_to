require 'spec_helper'

feature 'Songs Page' do
  scenario 'users can add a song' do
    visit songs_path
    click_on 'Add Song'

    fill_in 'Title', :with => 'My Heart Will Go On'
    fill_in 'Artist', :with => 'Celine Dion'
    fill_in 'Youtube Url', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
    click_on 'Create Song'

    expect(page).to have_content 'My Heart Will Go On'
  end
end