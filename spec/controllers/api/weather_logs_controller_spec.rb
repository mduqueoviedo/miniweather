require 'rails_helper'

RSpec.describe Api::WeatherLogsController do
  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'no logs' do

    end

    context 'existing logs' do
      it 'sends the last 10 queries' do

      end
    end
  end
end
