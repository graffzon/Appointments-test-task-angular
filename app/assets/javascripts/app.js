(function() {

  var app = angular.module('appointmentsNg', ['ng-token-auth', 'ipCookie', 'templates', 'ui.router', 'appointmentsNg-router', 'appointmentsNg-appointments'])

  app.config(function($authProvider) {
    return $authProvider.configure({
      apiUrl: 'http://localhost:3000/',
      confirmationSuccessUrl:  window.location.href
    });
  });

  app.controller('HomeController', ['$scope', '$auth', '$state', HomeController]);

  function HomeController($scope, $auth, $state) {
    $scope.counter = 1;
    $scope.plusOne = function() {
      $scope.counter = $scope.counter + 1;
    };
    $scope.greet = function() {
      alert($scope.counter);
    };
    $scope.isLoggedIn = function() {
      return $auth.userIsAuthenticated();
    };
    $scope.$on('auth:login-success', function(ev, user) {
      console.log('Welcome ' + user.email);
      $state.go('dashboard');
    });
  };
}).call(this);
