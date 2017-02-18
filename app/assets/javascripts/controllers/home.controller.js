angular.module('miniWeatherApp').controller('HomeController', [
    '$scope', '$http',
    function ($scope, $http) {
      $scope.search = {};

      $scope.submit = function() {
        var url = '/api/query_weather?query=' + $scope.search.city;

        $http.get(url).then(function(response) {
          console.log('Ok ' + response);
        }).catch(function(response) {
          console.log('Error: ' + response);
        });
      }

      $scope.getRandomLocation = function() {
        var url = '/api/query_weather?random=true';

        $http.get(url).then(function(response) {
          console.log('Ok ' + response);
        }).catch(function(response) {
          console.log('Error: ' + response);
        });
      };
    }
]);
