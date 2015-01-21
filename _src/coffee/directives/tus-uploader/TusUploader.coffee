module.exports = () ->
  restrict: 'E'
  transclude: true
  template: require './tus-uploader.jade'
  replace: true

  link: (scope, element, attrs) ->



