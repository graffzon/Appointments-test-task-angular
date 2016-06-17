(function() {
  var app = angular.module('appointmentsNg-appointments', ['ng-token-auth', 'ipCookie', 'templates', 'ui.router', 'appointmentsNg-router']);

  app.controller('AppointmentsController', ['$http', '$scope', function($http, $scope){
    var calendar = this;
    $scope.showAppForm = false;

    $scope.reloadAppointmentList = function() {
      $http.get('/appointments.json').success(function(data){
        calendar.appointments = data;
      });
    };

    $scope.newAppointment = function(action) {
      switch (action) {
        case 'show': $scope.showAppForm = true; break;
        case 'close': $scope.showAppForm = false; break;
        default: $scope.showAppForm = false; break;
      };
    };

    $scope.submitAppointment = function(appointmentForm) {
      $http.post('/appointments', appointmentForm).success(function(data) {
        $scope.showAppForm = false;
        appointmentForm = {};
        $scope.reloadAppointmentList();
      }).error(function(data){
        console.log(data);
      });
    };

    $scope.reloadAppointmentList();
  }]);

}).call(this);
