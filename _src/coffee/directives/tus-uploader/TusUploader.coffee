module.exports = () ->
  restrict: 'E'
  scope: {}
  template: require './tus-uploader.jade'
  replace: true

  link: (scope, element, attrs) ->

  controller: ($scope)->
    $scope.test = "test 1"


