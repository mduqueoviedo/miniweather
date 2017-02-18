require 'net/http'
require 'addressable/uri'
require 'json'

# Wrapper for the query to api
class WeatherQuery
  def initialize(units = 'metric')
    @host = Settings.weather_api.host
    @units = units
  end

  def query(user_query, is_random = false)
    weather_query = Addressable::URI.encode_component(weather_query_url(user_query, is_random))
    begin
      uri = Addressable::URI.parse(weather_query)
      response = Net::HTTP.get_response(uri)
      json_response = JSON.parse(response.body)

      store_log(is_random ? 'random' : user_query, json_response)
      process_response(json_response)
    rescue StandardError => error
      store_log(is_random ? 'random' : user_query, error.to_s)
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
      api_res_code: response['cod']
    )
  end

  def process_response(response)
    case response['cod']
    when 200
      {
        status: true,
        weather_main: response['weather'].first['main'],
        weather_description: response['weather'].first['description'],
        weather_icon: icon_url(response['weather'].first['icon']),
        temp: response['main']['temp'],
        temp_max: response['main']['temp_max'],
        temp_min: response['main']['temp_min'],
        wind_speed: response['wind']['speed'],
        wind_direction: response['wind']['deg'],
        city: response['name'],
        country: response['sys']['country'],
        latitude: response['coord']['lat'],
        longitude: response['coord']['lon'],
        rain_volume: response['rain'].present? ? response['rain']['3h'] : 0,
        snow_volume: response['snow'].present? ? response['snow']['3h'] : 0,
        cloudiness: response['clouds']['all'],
        time: DateTime.now
      }
    when 502, '502' # API Bug: This response comes in string format, the others in integer
      { status: false, error_message: 'City not found' }
    when 401
      { status: false, error_message: 'Unauthorized error. Please contact webmaster.' }
    else
      {
        status: false,
        error_message: "Unexpected api response: #{response['cod']}. Please contact webmaster."
      }
    end
  end

  def weather_query_url(user_query, is_random)
    weather_query = if is_random
                      rng = Random.new
                      lat = rng.rand(-90.0..90.0).round(3)
                      lon = rng.rand(-180.0..180.0).round(3)

                      "#{@host}#{Settings.weather_api.weather_coordinates_lat_path}" \
                        "#{lat}#{Settings.weather_api.weather_coordinates_lon_path}#{lon}"
                    else
                      "#{@host}#{Settings.weather_api.weather_query_path}#{user_query}"
                    end
    # Add units and api key
    weather_query += Settings.weather_api.units_query + @units if %w(metric imperial).include?(@units.downcase)
    weather_query + Settings.weather_api.key
  end

  def icon_url(icon_name)
    "#{Settings.weather_api.icon_full_path}#{icon_name}.png"
  end
end
