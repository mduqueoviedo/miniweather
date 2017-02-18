angular.module('miniWeatherApp').controller('HomeController', [
    '$scope', '$http',
    function ($scope, $http) {
      $scope.search = {};
      $scope.error = false;

      $scope.getWeather = function(isRandom) {
        $scope.weatherResult = null;
        $scope.error = false;
        var url = '';

        if (isRandom) {
          $scope.search = {};
          url = '/api/query_weather?random=true';
        } else {
          url = '/api/query_weather?query=' + $scope.search.city;
        };

        $http.get(url).then(function(response) {
          var res = response['data']['result'];
          if (res['status']) {
            $scope.weatherResult = res;
            console.log(res);
          } else {
            $scope.error = true;
            $scope.error_message = res['error_message'];
          }
        }).catch(function(response) {
          res = response['data']['result'];
          $scope.error = true;
          $scope.error_message = res['error_message'];
        });
      }
    }
]);
