$ = require "jquery" unless jQuery?
require 'angular/angular' unless angular?
require "./directives/tus-uploader/TusUploaderHelperComponents"

module.exports =
  angular.module('tus-uploader-test', ['tus-uploader-helper-components'])
  .directive("tusUploader", require("./directives/tus-uploader/TusUploader.coffee"))
