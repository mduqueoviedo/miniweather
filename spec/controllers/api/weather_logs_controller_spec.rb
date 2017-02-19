require 'rails_helper'
require 'json'

RSpec.describe Api::WeatherLogsController do
  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'no logs' do
      it 'sends empty object' do
        expect(WeatherLog.all.count).to eq(0)

        get :index
        json_response = JSON.parse(response.body)

        expect(json_response['logs'].count).to eq(0)
      end
    end

    context 'existing logs' do
      before do
        FactoryGirl.create_list(:weather_log, 15)
      end

      it 'sends the last 10 queries' do
        expect(WeatherLog.all.count).to eq(15)

        get :index
        json_response = JSON.parse(response.body)

        expect(json_response['logs'].count).to eq(10)
        expect(json_response['logs'].count).not_to eq(15)
      end
    end
  end
end
