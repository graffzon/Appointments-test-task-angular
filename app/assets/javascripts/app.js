(function() {

  var app = angular.module('appointmentsNg', ['ng-token-auth', 'ipCookie', 'templates', 'ui.router', 'appointmentsNg-router', 'appointmentsNg-appointments', 'directives-appointments'])

  app.config(function($authProvider) {
    return $authProvider.configure({
      apiUrl: 'http://localhost:3000/',
      confirmationSuccessUrl:  window.location.href
    });
  });

  app.controller('HomeController', ['$scope', '$auth', '$state', HomeController]);

  function HomeController($scope, $auth, $state) {
    $scope.isLoggedIn = function() {
      return $auth.userIsAuthenticated();
    };
    $scope.$on('auth:login-success', function(ev, user) {
      console.log('Welcome ' + user.email);
      $state.go('dashboard');
    });
    $scope.$on('auth:invalid', function(ev, user) {
      alert('Sorry, access is restricted only to authorized user');
      $state.go('login');
    });
    $scope.currentPage = function(pageName) {
      return $state.current.name == pageName;
    };
  };
}).call(this);
