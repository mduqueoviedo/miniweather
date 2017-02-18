# Little store for all the queries to the api
class WeatherLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_query, type: String
  field :raw_result, type: String
  field :api_res_code, type: String
end
