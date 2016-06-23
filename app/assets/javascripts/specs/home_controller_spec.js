describe("HomeController", function () {
  beforeEach(module('appointmentsNg'));
  beforeEach(module('ng-token-auth'));
  var $controller;
  var $scope;
  var $state;

  beforeEach(inject(function(_$controller_, $rootScope){
    $scope = $rootScope.$new();
    $state = { current: { name: '/dashboard' }};
    $controller = _$controller_('HomeController', {
        $scope: $scope,
        $state: $state
    });
  }));

  describe("$scope.currentPage", function () {
    it("returns true if current page equal to argument", function () {
      expect($scope.currentPage('/dashboard')).toEqual(true);
    });
  });
});
