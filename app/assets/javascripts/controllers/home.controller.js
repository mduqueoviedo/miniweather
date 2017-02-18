angular.module('miniWeatherApp').controller('HomeController', [
    '$scope', '$http',
    function ($scope, $http) {
      $scope.search = {};
      $scope.error = false;

      $scope.getWeather = function(isRandom) {
        $scope.weatherResult = null;
        $scope.error = false;
        var url = isRandom ? '/api/query_weather?random=true' : '/api/query_weather?query=' + $scope.search.city;

        $http.get(url).then(function(response) {
          var res = response['data']['result'];
          if (res['status']) {
            $scope.weatherResult = res;
            console.log(res);
          } else {
            console.log(res);
            $scope.error = true;
            $scope.error_message = res['error_message'];
          }
        }).catch(function(response) {
          res = response['data']['result'];
          $scope.error = true;
          $scope.error_message = res['error_message'];
          console.log(res);
        });
      }
    }
]);
