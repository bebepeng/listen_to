require 'spec_helper'

describe StatCompiler do
  before do
    user = create_user
    user.songs.create(:title => 'Say Something[Cover]', :artist => 'Pentatonix', :url => 'https://www.youtube.com/watch?v=0dYlvdLdK9w')
    user.songs.create(:title => 'Sunset In Paris', :artist => 'Sungha Jung', :url => 'http://youtu.be/RPlj673A7H0')
    VCR.use_cassette('youtube/songs') do
      @stats = StatCompiler.new(user)
    end
  end

  it 'returns all the titles that belong to a user' do
    expect(@stats.all_titles).to match_array ['Say Something[Cover]', 'Sunset In Paris']
  end

  it 'returns all the views for the songs that belong to a user' do
    expect(@stats.all_views).to match_array [18661338, 64604]
  end

  it 'returns all the likes for the songs that belong to a user' do
    expect(@stats.all_likes).to match_array [292382, 4169]
  end

  it 'returns all the dislikes for the songs that belong to a user' do
    expect(@stats.all_dislikes).to match_array [4225, 25]
  end

  it 'returns all the favorites for the songs that belong to a user' do
    expect(@stats.all_favorites).to match_array [0, 0]
  end

  it 'returns all the average views for the songs that belong to a user' do
    expect(@stats.avg_views).to eq 9362971
  end

  it 'returns all the average like ratio for the songs that belong to a user' do
    expect(@stats.avg_likeratio).to eq 0.989897332777442
  end
end