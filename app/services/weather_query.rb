require 'net/http'
require 'uri'
require 'json'

# Wrapper for the query to api
class WeatherQuery
  def initialize(units = 'metric')
    @host = Settings.weather_api.host
    @units = units
  end

  def query(user_query, is_random = false)
    weather_query =
      if is_random
        rng = Random.new
        lat = rng.rand(-90.0..90.0)
        lon = rng.rand(-180.0..180.0)

        "#{@host}#{Settings.weather_api.weather_coordinates_lat_path}" \
          "#{lat}#{Settings.weather_api.weather_coordinates_lon_path}#{lon}"
      else
        "#{@host}#{Settings.weather_api.weather_query_path}user_query"
      end
    # Add units and api key
    weather_query += Settings.weather_api.units_query + @units if %w(metric imperial).include?(@units.downcase)
    weather_query += Settings.weather_api.key

    begin
      uri = URI.parse(weather_query)
      response = Net::HTTP.get_response(uri)
      json_response = JSON.parse(response.body)

      store_log(user_query, json_response)
      process_response(json_response)
    rescue StandardError => error
      store_log(user_query, error.to_s)
      {
        status: false,
        error_message: error
      }
    end
  end

  private

  def store_log(user_query, response)
    WeatherLog.create!(
      user_query: user_query,
      raw_result: response,
      api_res_code: response['code']
    )
  end

  def process_response(response)
    case response['cod']
    when 200
      { status: true }
    when 502
      { status: false, error_message: 'City not found' }
    when 401
      { status: false, error_message: 'Unauthorized' }
    else
      { status: false, error_message: "Unexpected error: #{response['error']}" }
    end
  end
end
