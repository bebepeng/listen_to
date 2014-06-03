class Song < ActiveRecord::Base
  belongs_to :user

  validates :url, :format => {:with => /https?:\/\/youtu.be\/.{11}|https?:\/\/www.youtube.com\/watch\?v=.{11}/}

  def youtube_id
    url.scan(/https?:\/\/youtu.be\/(.{11})/).flatten[0] || url.scan(/https?:\/\/www.youtube.com\/watch\?v=(.{11})/).flatten[0]
  end

  def self.all_viewer_counts(user)
    user.songs.map do |song|
      youtube = Youtube.new(ENV['YOUTUBE_API_KEY'], song.youtube_id)
      {:title => song.title, :youtube_id => song.youtube_id, :views => youtube.views, :favorites => youtube.favorites}
    end
  end
end