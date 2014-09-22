app.controller("booksCtrl", function($scope, $http) {
//  Variable initialization
  $scope.bookData = [];
  $scope.showingBooks = [];
  $scope.indexBooksShowing = 5;

//  Angular filtering
  $scope.categoryFilter = {};


//  Getting Data from the Site via AJAX
  $scope.booksIndex = function() {
    $http({
      url: window.location.origin + "/books.json",
      method: "GET"
    }).success(function(data, status, headers, config) {
      $scope.bookData = data.books;

      $scope.showingBooks = $scope.bookData.slice(0, $scope.indexBooksShowing);
      console.log($scope.showingBooks);
    }).error(function(data, status, headers, config) {
      console.log("Couldn't get index data");
    });
  };
//  Helper to set bookimage stuff
  $scope.bookImage = function(book) {
    return book.image_url || '/assets/book_placeholder.png'
  };
// Infinite scroller
  $scope.loadMore = function() {
    console.log("ScrollMore");
    if ($scope.showingBooks.length < $scope.bookData.length) {
      var next = $scope.showingBooks.length;
      console.log("Next is ", next);
      var booksToAdd = $scope.bookData.slice(next, next + 2);
      console.log("Books to add", booksToAdd);
      $scope.showingBooks = $scope.showingBooks.concat(booksToAdd);
      console.log($scope.showingBooks);
    }
  };
});