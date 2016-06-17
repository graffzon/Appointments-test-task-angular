(function() {
  var app = angular.module('directives-appointments', ['templates']);

  app.directive("appointmentsList", function() {
    return {
      restrict: 'E',
      templateUrl: "appointments/index.html"
    };
  });

  app.directive("newAppointmentForm", function() {
    return {
      restrict: 'E',
      templateUrl: "appointments/_form.html"
    };
  })

}).call(this);
