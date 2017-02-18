CORRECT_API_RESPONSE = {
  'coord' => {
    'lon' => -4.72,
    'lat' => 41.66
  },
  'weather' => [
    {
      'id' => 500,
      'main' => 'Rain',
      'description' => 'light rain',
      'icon' => '10d'
    }
  ],
  'base' => 'stations',
  'main' => {
    'temp' => 10.62,
    'pressure' => 944.41,
    'humidity' => 97,
    'temp_min' => 10.62,
    'temp_max' => 10.62,
    'sea_level' => 1033.45,
    'grnd_level' => 944.41
  },
  'wind' => {
    'speed' => 3.12,
    'deg' => 291.001
  },
  'rain' => {
    '3h' => 0.4
  },
  'clouds' => {
    'all' => 68
  },
  'dt' => 1_487_428_943,
  'sys' => {
    'message' => 0.0027,
    'country' => 'ES',
    'sunrise' => 1_487_401_748,
    'sunset' => 1_487_440_614
  },
  'id' => 3_106_672,
  'name' => 'Valladolid',
  'cod' => 200
}.freeze

NOT_FOUND_API_RESPONSE = {
  'cod' => '502',
  'message' => 'Error => Not found city'
}.freeze

INVALID_KEY_API_RESPONSE = {
  'cod' => 401,
  'message' => 'Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.'
}.freeze
