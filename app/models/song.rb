class Song < ActiveRecord::Base
  belongs_to :user

  validates :url, :format => {:with => /https?:\/\/youtu.be\/.{11}|https?:\/\/www.youtube.com\/watch\?v=.{11}/}

  def youtube_id
    url.scan(/https?:\/\/youtu.be\/(.{11})/).flatten[0] || url.scan(/https?:\/\/www.youtube.com\/watch\?v=(.{11})/).flatten[0]
  end

  def self.all_view_counts(user)
    youtube = Youtube.new(ENV['YOUTUBE_API_KEY'])
    user.songs.map do |song|
      {:title => song.title, :youtube_id => song.youtube_id, :count => youtube.view_count(song.youtube_id)}
    end
  end
end