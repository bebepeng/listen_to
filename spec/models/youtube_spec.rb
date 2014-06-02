require 'spec_helper'

describe Youtube do
  it 'gets the view counts for a video' do
    VCR.use_cassette('youtube/youtube_class') do
      youtube = Youtube.new(ENV['YOUTUBE_API_KEY'])
      expect(youtube.view_count('-zQxHBr2NPg')).to eq 217
    end
  end
end