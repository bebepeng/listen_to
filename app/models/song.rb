class Song < ActiveRecord::Base
  belongs_to :user

  def youtube_id
    url.scan(/https?:\/\/youtu.be\/(.{11})/).flatten[0] || url.scan(/https?:\/\/www.youtube.com\/watch\?v=(.{11})/).flatten[0]
  end
end