require 'rails_helper'

RSpec.describe Api::WeatherQueriesController do
  describe '#query_weather' do
    let(:weather_query_double) { double(WeatherQuery) }

    context 'service is running' do
      it 'gets weather from valid query' do
        expect(WeatherQuery).to receive(:new).and_return(weather_query_double)
        expect(weather_query_double)
          .to receive(:query)
          .with('some city, country', false)
          .and_return(CORRECT_API_RESPONSE)

        get :query_weather, params: { query: 'some city, country', random: false }

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json_response['result']['name']).to eq('Valladolid')
      end

      it 'gets weather in random location' do
        expect(WeatherQuery).to receive(:new).and_return(weather_query_double)
        expect(weather_query_double)
          .to receive(:query)
          .with(nil, true)
          .and_return(CORRECT_API_RESPONSE)

        get :query_weather, params: { random: true }

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json_response['result']['name']).to eq('Valladolid')
      end

      it 'receives errors from api' do
        expect(WeatherQuery).to receive(:new).and_return(weather_query_double)
        expect(weather_query_double)
          .to receive(:query)
          .with('completely unknown place', false)
          .and_return(NOT_FOUND_API_RESPONSE)

        get :query_weather, params: { query: 'completely unknown place', random: false }

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json_response['result']['cod']).to eq('502')
        expect(json_response['result']['message']).to eq('Error => Not found city')
      end
    end

    context 'service is not available' do
      it 'encodes error to user' do
        expect(WeatherQuery).to receive(:new).and_return(weather_query_double)
        expect(weather_query_double)
          .to receive(:query)
          .and_return('status' => false, 'error_message' => 'Error!1!!')

        get :query_weather, params: { query: 'some city, country', random: false }

        json_response = JSON.parse(response.body)
        expect(json_response['result']['status']).to be false
        expect(json_response['result']['error_message']).to eq('Error!1!!')
      end
    end
  end
end
