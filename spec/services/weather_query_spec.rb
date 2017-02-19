require 'rails_helper'
require 'byebug'

RSpec.describe WeatherQuery do
  subject { WeatherQuery.new }

  describe '#new' do
    it 'initalizes the class' do
      expect(subject).to be_a(WeatherQuery)
    end
  end

  describe '#query' do
    it 'gets the weather' do
      stub_request(
        :get, "http://api.openweathermap.org/data/2.5/weather?q=Valladolid,%20Spain&units=metric#{Settings.weather_api.key}"
      ).to_return(status: 200, body: CORRECT_API_RESPONSE.to_json, headers: {})

      res = subject.query('Valladolid, Spain')

      expect(res[:status]).to be true
      expect(res[:weather_main]).to eq('Rain')
    end

    it 'also works with non ascii requests' do
      stub_request(
        :get,
        "http://api.openweathermap.org/data/2.5/weather?q=Valladolid,%20Espa%C3%B1a&units=metric#{Settings.weather_api.key}"
      ).to_return(status: 200, body: CORRECT_API_RESPONSE.to_json, headers: {})

      res = subject.query('Valladolid, España')

      expect(res[:status]).to be true
    end

    it 'stores a log entry after each query' do
      stub_request(
        :get,
        "http://api.openweathermap.org/data/2.5/weather?q=any%20query&units=metric#{Settings.weather_api.key}"
      ).to_return(status: 200, body: CORRECT_API_RESPONSE.to_json, headers: {})

      expect { subject.query('any query') }.to change { WeatherLog.count }.by(1)
    end

    context 'service not available' do
      it 'sends error to user' do
        stub_request(
          :get,
          "http://api.openweathermap.org/data/2.5/weather?q=any%20query&units=metric#{Settings.weather_api.key}"
        ).to_return(status: 500, body: nil, headers: {})

        res = subject.query('any query')

        expect(res[:status]).to be false
        expect(res[:error_message]).not_to be_blank
      end
    end
  end
end
