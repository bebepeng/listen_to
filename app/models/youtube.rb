require 'faraday'
require 'json'

class Youtube
  attr_reader :token, :id, :statistics

  def initialize(token, id)
    @token = token
    @id = id
    @statistics = api_call('statistics')['items'].first['statistics']
  end

  def views
    statistics['viewCount'].to_i
  end

  def favorites
    statistics['favoriteCount'].to_i
  end

  private

  def api_call(part)
    response = Faraday.get("https://www.googleapis.com/youtube/v3/videos?id=#{id}&key=#{token}&part=#{part}")
    JSON.parse(response.body)
  end
end