Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    get 'query_weather' => 'weather_queries#query_weather'
  end
end
