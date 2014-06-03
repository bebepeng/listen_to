require 'spec_helper'

describe Youtube do
  it 'gets the viewer statistics for a video' do
    VCR.use_cassette('youtube/youtube_class') do
      youtube = Youtube.new(ENV['YOUTUBE_API_KEY'], '-zQxHBr2NPg')
      expect(youtube.views).to eq 217
      expect(youtube.favorites).to eq 0
    end
  end
end