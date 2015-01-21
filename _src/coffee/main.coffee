global.$ = global.jQuery = $ = require "jquery" unless jQuery
require 'angular/angular' unless angular?

module.exports =
  angular.module('tus-uploader-test', [])
  .directive("tusUploader", require("./directives/tus-uploader/TusUploader.coffee"))
