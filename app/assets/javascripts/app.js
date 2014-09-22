var app = angular.module("booksApp", ['infinite-scroll', 'ui.bootstrap', 'doowb.angular-pusher', 'ngResource'])
  .config(['PusherServiceProvider',
    function(PusherServiceProvider) {
      PusherServiceProvider
        .setToken('c88a3dc1a1d4cf230ab8')
        .setOptions({});
    }
  ]);
