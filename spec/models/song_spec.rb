require 'spec_helper'

describe Song do
  it 'returns songs that belong to a user' do
    user = create_user
    user.songs.create(:title => 'Do Re Mi', :artist => 'Julie Andrews', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')
    user.songs.create(:title => 'yay', :artist => 'Julie Andrews', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')

    other_user = create_user(:email => 'bob@email.com', :username => 'bob')
    other_user.songs.create(:title => 'other song', :artist => 'Julie Andrews', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')

    expect(user.songs.to_a.map { |song| song.title }).to eq ['Do Re Mi', 'yay']
  end

  it 'returns the youtube id' do
    user = create_user
    song1 = user.songs.create(:title => 'Do Re Mi', :artist => 'Sungha Jung', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')
    song2 = user.songs.create(:title => 'Do Re Mi', :artist => 'Sungha Jung', :url => 'http://youtu.be/RPlj673A7H0')
    expect(song1.youtube_id).to eq 'RPlj673A7H0'
    expect(song2.youtube_id).to eq 'RPlj673A7H0'
  end
end