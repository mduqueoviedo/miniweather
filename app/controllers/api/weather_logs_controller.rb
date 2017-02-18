module Api
  # Api-like controller to get the last queries
  class WeatherLogsController < ApplicationController
    def index
      res = WeatherLog.all.order_by(:created_at => 'desc').limit(10)
      render json: { result: res.map(&:as_json) }
    end
  end
end
