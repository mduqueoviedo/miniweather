require 'rails_helper'

RSpec.describe WeatherQuery do
  describe '#query_weather' do
    it 'gets the weather' do
    end

    it 'does not cause error when query has not ascii' do
    end

    it 'stores a log entry after each query' do
      expect(WeatherQuery).to receive(:new).and_return(weather_query_double)
      expect(weather_query_double)
        .to receive(:query)
        .with(nil, true)
        .and_return(CORRECT_API_RESPONSE)

      expect{ get :query_weather, params: { random: true } }.to change { WeatherLog.count }.by(1)
    end

    context 'service not available' do
      it 'sends error to user' do

      end
    end
  end
end
