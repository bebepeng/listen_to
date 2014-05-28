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

  it 'validates the format of a youtube link' do
    user = create_user
    valid_song = user.songs.new(:title => 'The Milky Way', :artist => 'Sungha Jung', :url => 'https://www.youtube.com/watch?v=wI-XdM7rIo8')
    expect(valid_song.valid?).to eq true

    another_valid_song = user.songs.new(:title => 'The Milky Way', :artist => 'Sungha Jung', :url => 'http://youtu.be/wI-XdM7rIo8')
    expect(another_valid_song.valid?).to eq true

    invalid_song = user.songs.new(:title => 'Let It Go', :artist => 'Sungha Jung', :url => 'http://www.dailymotion.com/video/x1n1q39_let-it-go-sungha-jung-frozen-ost_music')
    invalid_song.valid?

    expect(invalid_song.errors[:url].length).to eq 1
  end
end