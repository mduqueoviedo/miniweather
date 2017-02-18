angular.module('miniWeatherApp').controller('HomeController', [
    '$scope', '$http',
    function ($scope, $http) {
      $scope.search = {};
      $scope.error = false;

      $scope.getWeather = function(isRandom) {
        $scope.weatherResult = null;
        $scope.error = false;
        $scope.loading = true;

        if (isRandom) {
          $scope.search = {};
          var url = '/api/query_weather?random=true';
        } else {
          var url = '/api/query_weather?query=' + $scope.search.city;
        };

        $http.get(url).then(function(response) {
          $scope.loading = false;
          var res = response['data']['result'];
          if (res['status']) {
            $scope.weatherResult = res;
            $scope.reloadLogs();
          } else {
            $scope.error = true;
            $scope.error_message = res['error_message'];
          }
        }).catch(function(response) {
          $scope.loading = false;
          res = response['data']['result'];
          $scope.error = true;
          $scope.error_message = res['error_message'];
        });
      }

      $scope.reloadLogs = function() {
        var url = '/api/weather_logs';

        $http.get(url).then(function(response) {
          $scope.weatherLogs = response['data']['logs'];
        }).catch(function(response) {
          $scope.weatherLogs = {};
        });
      };

      $scope.reloadLogs();
    }
]);
