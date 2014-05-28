require 'spec_helper'

feature 'Songs Page' do
  feature 'guest interctions' do
    before do
      user = create_user
      login(user)
      create_song(user)
      click_on 'Log Out'
    end
    scenario 'guests cannot add a song' do
      visit '/'
      click_on 'Click here for more.'
      expect(page).to have_no_link 'Add a New Song'
    end

    scenario 'guests cannot edit a song' do
      visit '/'
      click_on 'Click here for more.'
      expect(page).to have_content 'My Heart Will Go On'
      expect(page).to have_no_link 'Edit Song'
    end

    scenario 'guests cannot delete a song' do
      visit '/'
      click_on 'Click here for more.'
      expect(page).to have_content 'My Heart Will Go On'
      expect(page).to have_no_button 'Delete Song'
    end

    scenario 'guests can view youtube songs' do
      visit '/'
      click_on 'Click here for more.'
      click_on 'Listen here'
      expect(page).to have_video 'DNyKDI9pn0Q'
    end
  end


  feature 'signed in user interactions' do
    before do
      @user = create_user
      login(@user)
    end

    scenario 'users can visit their songs from the home link in the header' do
      click_on 'Home'

      expect(page).to have_content 'What You Listen to'
    end

    scenario 'users can add a song' do
      create_song(@user)
      visit user_songs_path(@user)

      expect(page).to have_content 'My Heart Will Go On'
      expect(page).to have_content 'Celine Dion'
    end

    scenario 'users see errors when incorrectly filling out form' do
      visit new_user_song_path(@user)
      fill_in 'Title', :with => 'The Milky Way'
      fill_in 'Artist', :with => 'Sungha Jung'
      fill_in 'YouTube URL', :with => 'https://www.youtube.com/wI-XdM7rIo8'
      click_on 'Create Song'

      expect(page).to have_content 'YouTube URL is invalid'
    end

    scenario 'only songs associated with a user are displayed' do
      create_song(@user)
      click_on 'Log Out'

      another_user = create_user(:email => 'bob@email.com', :username => 'bob')
      login(another_user)
      add_another_new_song(another_user)

      expect(page).to have_content 'Titanic Song'
      expect(page).to have_no_content 'My Heart Will Go On'
    end

    scenario 'Users can edit a song' do
      create_song(@user)
      visit user_songs_path(@user)

      click_on 'Edit Song'
      fill_in 'Title', :with => 'That Titanic Song'
      click_on 'Update Song'

      expect(page).to have_content 'That Titanic Song'
    end

    scenario 'Users can delete a song' do
      create_song(@user)
      visit user_songs_path(@user)

      click_on 'Delete Song'
      expect(page).to_not have_content 'My Heart Will Go On'
      expect(page).to_not have_content 'Celine Dion'
    end

    scenario 'Users act as guest on other users pages' do
      another_user = create_user(:email => 'bob@gmail.com', :username => 'bob')
      create_song(another_user)

      visit user_songs_path(another_user)
      expect(page).to have_content 'My Heart Will Go On'
      expect(page).to have_no_link 'Add a New Song'
      expect(page).to have_no_link 'Edit Song'
      expect(page).to have_no_button 'Delete Song'
    end
  end


  def have_video(youtube_id)
    have_css("iframe[src='//www.youtube.com/embed/#{youtube_id}']")
  end

  def add_another_new_song(user)
    visit user_songs_path(user)
    click_on 'Add a New Song'

    fill_in 'Title', :with => 'Titanic Song'
    fill_in 'Artist', :with => 'Celine Dion'
    fill_in 'YouTube URL', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
    click_on 'Create Song'
  end
end