(function() {
  var app = angular.module('directives-appointments', ['templates']);

  app.directive("appointmentsList", function() {
    return {
      restrict: 'E',
      templateUrl: "appointments/index.html"
    };
  });

}).call(this);
