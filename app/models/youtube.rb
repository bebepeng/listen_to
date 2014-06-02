require 'faraday'
require 'json'

class Youtube
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def view_count(id)
    statistics = api_call(id, 'statistics')['items'].first['statistics']
    statistics['viewCount'].to_i
  end

  private

  def api_call(id, part)
    response = Faraday.get("https://www.googleapis.com/youtube/v3/videos?id=#{id}&key=#{token}&part=#{part}")
    JSON.parse(response.body)
  end
end