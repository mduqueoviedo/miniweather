require 'net/http'
require 'json'

# Wrapper for the query to api
class WeatherQuery
  def initialize
    @host = Settings.weather_api.host
  end

  def query(user_query)
    response = Net::HTTP.get("#{@host}#{Settings.weather_query_path}user_query")
    store_log(user_query, response)
  end

  private

  def store_log(user_query, raw_response)
    json_response = JSON.parse(raw_response)

    WeatherLog.create!(
      user_query: user_query,
      raw_result: raw_response,
      api_res_code: json_response['code']
    )
  end
end
