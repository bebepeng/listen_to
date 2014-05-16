require 'spec_helper'

feature 'Songs Page' do
  feature 'guest interctions' do
    scenario 'guests cannot add a song' do
      create_valid_user
      visit '/'
      click_on 'Click here for more.'
      expect(page).to have_no_link 'Add a New Song'
    end
  end
  feature 'signed in user interactions' do
    before do
      @user = create_valid_user
      login(@user)
    end
    scenario 'users can add a song' do
      add_new_song(@user)

      expect(page).to have_content 'My Heart Will Go On'
      expect(page).to have_content 'Celine Dion'
      expect(page).to have_youtube_link 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
    end

    scenario 'only songs associated with a user are displayed' do
      add_new_song(@user)
      click_on 'Log Out'

      another_user = create_another_valid_user
      login(another_user)
      add_another_new_song(another_user)

      expect(page).to have_content 'Titanic Song'
      expect(page).to have_no_content 'My Heart Will Go On'
    end

    scenario 'Users can edit a song' do
      add_new_song(@user)

      click_on 'Edit Song'
      fill_in 'Title', :with => 'That Titanic Song'
      click_on 'Update Song'

      expect(page).to have_content 'That Titanic Song'
    end

    scenario 'Users can delete a song' do
      add_new_song(@user)

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

  def create_another_valid_user
    User.create!(:email => 'bob@email.com', :username => 'Bob', :password => 'password')
  end

  def add_new_song(user)
    visit user_songs_path(user)
    click_on 'Add a New Song'

    fill_in 'Title', :with => 'My Heart Will Go On'
    fill_in 'Artist', :with => 'Celine Dion'
    fill_in 'YouTube URL', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
    click_on 'Create Song'
  end

  def add_another_new_song(user)
    visit user_songs_path(user)
    click_on 'Add a New Song'

    fill_in 'Title', :with => 'Titanic Song'
    fill_in 'Artist', :with => 'Celine Dion'
    fill_in 'YouTube URL', :with => 'https://www.youtube.com/watch?v=DNyKDI9pn0Q'
    click_on 'Create Song'
  end

  def login(user)
    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'password'
    click_on 'Log In'
  end
end