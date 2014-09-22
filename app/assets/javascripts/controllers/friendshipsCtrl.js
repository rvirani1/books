app.controller("FriendshipsCtrl", function($scope, $resource) {

  var friendResource = $resource(
      '/friends'
  );

  var userResource = $resource(
      '/users'
  );

  var requestsResource = $resource(
      '/requests'
  );

  $scope.friends = friendResource.query();
  $scope.users = userResource.query();
  $scope.requests = requestsResource.query();

  $scope.request = function() {
    alert('You clicked me');
  };

  var requestResource = $resource(
    'users/:id/friend', {id: ''}
  )




});
