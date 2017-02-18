require 'rails_helper'

RSpec.describe Api::WeatherQueriesController do
  describe '#query_weather' do
    context 'service is running' do
      it 'gets weather' do
      end

      it 'receives errors from api' do
      end
    end

    context 'service is not available' do
      it 'encodes error to user' do
      end
    end

  end
end
