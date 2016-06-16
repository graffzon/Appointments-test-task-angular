(function() {
  var app = angular.module('appointmentsNg-appointments', ['ng-token-auth', 'ipCookie', 'templates', 'ui.router', 'appointmentsNg-router']);

  app.controller('AppointmentsController', ['$http', function($http){
    var calendar = this;

    $http.get('/appointments.json').success(function(data){
      calendar.appointments = data;
    });

  }]);

}).call(this);
