module Api
  # Api-like controller to get the weather from the external api
  class WeatherQueriesController < ApplicationController
    def query_weather
      random_location = params[:random].present? ? params[:random] == 'true' : false
      weather_response = WeatherQuery.new.query(params[:query], random_location)
      render json: { result: weather_response }
    end
  end
end
