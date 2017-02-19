FactoryGirl.define do
  factory :weather_log do
    user_query { 'some query, user' }
    raw_result { 'some random result' }
    api_res_code { %w(200 401 502).sample }
  end
end
