(function() {
  var app = angular.module('appointmentsNg-router', ['ng-token-auth', 'ipCookie', 'templates', 'ui.router'])

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
        .state('dashboard', {
          url: "/dashboard",
          templateUrl: "dashboard.html",
          resolve: {
            auth: function($auth) {
              return $auth.validateUser();
            },
            error: function() {
              alert('Access restricted');
            }
          }
        });

      $stateProvider
        .state('app', {
          abstract: true,
          url: '/',
          templateUrl: ""
        });
    });

}).call(this);
