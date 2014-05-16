require 'spec_helper'

feature 'Songs Page' do
  feature 'guest interctions' do
    scenario 'guests cannot add a song'
  end
  feature 'user interctions' do
    before do
      create_valid_user
      visit '/'
      click_on 'Log In'
      fill_in 'Email', :with => 'bebe@email.com'
      fill_in 'Password', :with => 'password'
      click_on 'Log In'
    end
    scenario 'signed in users can add a song' do
      visit songs_path
      click_on 'Add a New Song'

      fill_in 'Title', :with => 'My Heart Will Go On'
      fill_in 'Artist', :with => 'Celine Dion'
      fill_in 'YouTube URL', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
      click_on 'Create Song'

      expect(page).to have_content 'My Heart Will Go On'
      expect(page).to have_content 'Celine Dion'
      expect(page).to have_youtube_link 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
    end

    scenario 'Users can edit a song' do
      visit songs_path
      click_on 'Add a New Song'

      fill_in 'Title', :with => 'My Heart Will Go On'
      fill_in 'Artist', :with => 'Celine Dion'
      fill_in 'YouTube URL', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
      click_on 'Create Song'

      click_on 'Edit Song'
      fill_in 'Title', :with => 'That Titanic Song'
      click_on 'Update Song'

      expect(page).to have_content 'That Titanic Song'
    end

    scenario 'Users can delete a song' do
      visit songs_path
      click_on 'Add a New Song'

      fill_in 'Title', :with => 'My Heart Will Go On'
      fill_in 'Artist', :with => 'Celine Dion'
      fill_in 'YouTube URL', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
      click_on 'Create Song'

      click_on 'Delete Song'
      expect(page).to_not have_content 'My Heart Will Go On'
      expect(page).to_not have_content 'Celine Dion'
    end
  end

  def have_youtube_link(url)
    have_css("a[href='#{url}']")
  end

  def create_valid_user
    User.create!(:email => 'bebe@email.com', :username => 'Bebe', :password => 'password')
  end
end