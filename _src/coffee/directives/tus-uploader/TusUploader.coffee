$ = require "jquery"
_ = require "underscore"
tus = require "TUS-Client"

module.exports = () ->
  restrict: 'E'
  scope: {}
  controllerAs: "ctrl"
  template: require './tus-uploader.jade'
  replace: true

  link: (scope, element, attrs) ->

  controller: ($scope)->
    queueList = []
    selectedFileList = []
    isObjectDragOver = false

    @fileList = []
    @rememberOverwriteAnswer = false
    @overwrite = false
    @uploading = false
    @currentFile = null
    @showModal = false
    upload = null
    uploadCheck = null
    options =
      endpoint: 'http://localhost:1080/files/'
      resetBefore: false
      resetAfter: true

    updateScope = ->
      try
        $scope.$digest()
      catch e
        console.log(e)

    @haveFileAPI = ->
      tus.UploadSupport

    @getValueIf = (variable, upload, stop) ->
      return if variable then stop else upload

    @isSelectedFileListEmpty = ->
      return selectedFileList.length == 0

    @isFileListEmpty = ->
      return @fileList.length == 0

    @isDragDialogVisible = ->
      return @isFileListEmpty() || isObjectDragOver

    @isDragMessageVisible = ->
      return !isObjectDragOver && @haveFileAPI()

    @isDropMessageVisible = ->
      return isObjectDragOver && @haveFileAPI()

    @isUploadEnabled = ->
      return !(@isFileListEmpty() || queueList.length == 0)

    @onDrop = (event) ->
      event.preventDefault()
      return false if (!@haveFileAPI())
      isObjectDragOver = false;
      @addFiles(event.dataTransfer.files)

    @onDragOver = ->
      isObjectDragOver = true

    @onDragLeave = ->
      isObjectDragOver = false

    @onFileInputSelection = ->
      @addFiles(event.target.files)

    @addFiles = (fileList) ->
      _.each(fileList, (file) =>
        file.selected = false
        file.uploading = false
        file.uploaded = false
        @fileList.push(file)
        loadImage(file)
      )
      queueList = _.filter(@fileList, (file) ->
        return !file.uploaded
      )

    loadImage = (file) ->
      return unless (file.type.match("image.(jpeg|png|gif)"))
      reader = new FileReader()
      reader.onload = (event) ->
        file.imageDataAsStyle = "background-image:url(" + event.target.result + ")"
        updateScope()
      reader.readAsDataURL(file)

    @toggleSelection = (file) ->
      file.selected = (if file.selected then false else true)
      if (file.selected)
        selectedFileList.push(file);
      else
        selectedFileList = _.reject(selectedFileList, (f) ->
          return f == file;
        )
      event.stopPropagation()

    @getSelectedFileListLength = ->
      return if selectedFileList.length == 0 then "" else selectedFileList.length.toString() + " ";

    @deselectAll = ->
      _.each(selectedFileList, (file) ->
        file.selected = false
      )
      selectedFileList = []

    @isFileSelected = (file) ->
      return file.selected

    @isFileUploading = (file) ->
      return file.uploading

    @isFileUploaded = (file) ->
      return file.uploaded

    @removeSelectedFiles = ->
      @fileList = _.difference(@fileList, selectedFileList)
      selectedFileList = []

    @toggleUpload = ->
      if (@uploading)
        @stopFileUpload()
      else
        @startFileUpload()

    @stopFileUpload = ->
      @uploading = false
      @currentFile.uploading = false if @currentFile?
      uploadCheck.stop() if uploadCheck?
      upload.stop() if upload?
      try
        @apply() if @apply?
      catch e
        console.log(e)

    @startFileUpload = ->
      files = @fileList
      options =
        endpoint: 'http://localhost:1080/files/'
        resetBefore: $('#reset_before').prop('checked') # if resetBefore is true file always uploads from first byte
        resetAfter: true # clear localStorage after upload completes successfully
        chunkSize: 1 # if chunkSize is not null then file uploads in chunks
        checksum: false
        minChunkSize: 51200
        maxChunkSize: 2097152
        moveFileAfterUpload: true
        path: "" # Where we want to put uploaded file on server

      openDialogIfFileExist = (error)->
        if (error instanceof Error)
          Q.reject(error)
        else
          Q.reject(error) unless (confirm("File(s) \"#{error.foundFilesString}\" are on server. Do you want to overwrite them?"))
      startUpload = (result)->
        return tus.uploadAll(files, options)
      displayUploadedFiles = (result)->
        console.log(result)
      updateProgress = (result)->
        result.value.file.uploading = result.value.percentage != '100.00'
        result.value.file.uploaded = result.value.percentage == '100.00'
        result.value.file.progress = "width: #{result.value.percentage}%"
        updateScope()
      logErrors = (error) ->
        console.log(error)
      resetUI = () ->


      tus.checkAll(@fileList, options)
        .catch(openDialogIfFileExist)
        .then(startUpload)
        .then(displayUploadedFiles)
        .progress(updateProgress)
        .catch(logErrors)
        .fin(resetUI)


