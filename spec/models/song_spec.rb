require 'spec_helper'

describe Song do
  it 'returns songs that belong to a user' do
    @user = create_user
    @user.songs.create(:title => 'Do Re Mi', :artist => 'Julie Andrews', :url => 'http://www.youtube.com/something')
    @user.songs.create(:title => 'yay', :artist => 'Julie Andrews', :url => 'http://www.youtube.com/something')

    @other_user = create_user(:email => 'bob@email.com', :username => 'bob')
    @other_user.songs.create(:title => 'other song', :artist => 'Julie Andrews', :url => 'http://www.youtube.com/something')

    expect(@user.songs.to_a.map { |song| song.title }).to eq ['Do Re Mi', 'yay']
  end
end