(function() {

  var app = angular.module('appointmentsNg', ['ng-token-auth', 'ipCookie', 'templates', 'ui.router'])

  app.config(function($authProvider) {
    return $authProvider.configure({
      apiUrl: 'http://localhost:3000/',
      confirmationSuccessUrl:  window.location.href
    });
  });

  app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");

    $stateProvider
      .state('sign_up', {
        url: "/sign-up",
        templateUrl: "devise/sign_up.html"
      });

    $stateProvider
      .state('login', {
        url: "/login",
        templateUrl: "devise/login.html"
      });

    $stateProvider
      .state('app', {
        abstract: true,
        url: '/',
        templateUrl: ""
      });
  });



  app.controller('HomeController', ['$scope', '$auth', HomeController]);

  function HomeController($scope, $auth) {
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

    $scope.handleRegBtnClick = function() {
      $auth.submitRegistration($scope.registrationForm)
        .then(function(resp) {
          console.log("success!");
        })
        .catch(function(resp) {
          console.log("Registration Failed! =(" + resp);
        });
    };
    $scope.handleLoginBtnClick = function() {
      $auth.submitLogin($scope.loginForm)
        .then(function(resp) {
          console.log("success!");
        })
        .catch(function(resp) {
          console.log("Registration Failed! =(" + resp);
        });
    };
  };

}).call(this);
