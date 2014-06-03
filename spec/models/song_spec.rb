require 'spec_helper'

describe Song do
  before do
    @user = create_user
  end

  it 'returns songs that belong to a user' do
    @user.songs.create(:title => 'Do Re Mi', :artist => 'Julie Andrews', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')
    @user.songs.create(:title => 'yay', :artist => 'Julie Andrews', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')

    other_user = create_user(:email => 'bob@email.com', :username => 'bob')
    other_user.songs.create(:title => 'other song', :artist => 'Julie Andrews', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')

    expect(@user.songs.to_a.map { |song| song.title }).to eq ['Do Re Mi', 'yay']
  end

  it 'returns the youtube id' do
    song1 = @user.songs.create(:title => 'Do Re Mi', :artist => 'Sungha Jung', :url => 'https://www.youtube.com/watch?v=RPlj673A7H0')
    song2 = @user.songs.create(:title => 'Do Re Mi', :artist => 'Sungha Jung', :url => 'http://youtu.be/RPlj673A7H0')
    expect(song1.youtube_id).to eq 'RPlj673A7H0'
    expect(song2.youtube_id).to eq 'RPlj673A7H0'
  end

  it 'validates the format of a youtube link' do
    valid_song = @user.songs.new(:title => 'The Milky Way', :artist => 'Sungha Jung', :url => 'https://www.youtube.com/watch?v=wI-XdM7rIo8')
    expect(valid_song.valid?).to eq true

    another_valid_song = @user.songs.new(:title => 'The Milky Way', :artist => 'Sungha Jung', :url => 'http://youtu.be/wI-XdM7rIo8')
    expect(another_valid_song.valid?).to eq true

    invalid_song = @user.songs.new(:title => 'Let It Go', :artist => 'Sungha Jung', :url => 'http://www.dailymotion.com/video/x1n1q39_let-it-go-sungha-jung-frozen-ost_music')
    invalid_song.valid?

    expect(invalid_song.errors[:url].length).to eq 1
  end

  it 'finds all the viewer statistics associated with a users videos' do
    @user.songs.create(:title => 'Say Something[Cover]', :artist => 'Pentatonix', :url => 'https://www.youtube.com/watch?v=0dYlvdLdK9w')
    @user.songs.create(:title => 'Sunset In Paris', :artist => 'Sungha Jung', :url => 'http://youtu.be/RPlj673A7H0')

    VCR.use_cassette('youtube/songs') do
      expect(Song.all_viewer_counts(@user)).to match_array [{:title => "Say Something[Cover]", :youtube_id => "0dYlvdLdK9w", :views => 18661338, :favorites => 0, :likes => 292382},
                                                            {:title => "Sunset In Paris", :youtube_id => "RPlj673A7H0", :views => 64604, :favorites => 0, :likes => 4169}]
    end
  end
end