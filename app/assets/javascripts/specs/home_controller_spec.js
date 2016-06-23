describe("HomeController", function () {
  beforeEach(module('appointmentsNg'));
  var $controller;

  beforeEach(inject(function(_$controller_){
    $controller = _$controller_;
  }));

  describe("$scope.currentPage", function () {
    it("returns true if current page equal to argument", function () {
      var $scope = {};
      var controller = $controller('HomeController', { $scope: $scope });

      expect($scope.currentPage('/dashboard')).toEqual(true);
    });
  });
});
