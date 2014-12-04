class App.Util.Form

  constructor: () ->
    App.Vent.subscribe 'form:documents:new', @newDocument
    App.Vent.subscribe 'form:documents:delete', @deleteDocument

  newDocument: (data) ->
    new Dropzone('#dropzone',
      paramName: 'document[attachment]'
      autoProcessQueue: false
      uploadMultiple: false
      parallelUploads: 10
      maxFiles: 10

      init: ->
        $(@element).find('button[type=submit]').on 'click', (e) =>
          e.preventDefault()
          e.stopPropagation()
          @processQueue()

        @on 'sending', ->
          # Gets triggered when the form is actually being sent.
          # Hide the success button or the complete form.

        @on 'success', (files, response) ->
          # console.log response

        @on 'error', (files, response) ->
          # Gets triggered when there was an error sending the files.
          # Maybe show form again, and notify user of error
          console.log files, response

        @on "complete", (file) ->
           if @getUploadingFiles().length is 0 and @getQueuedFiles().length is 0
            m = new App.Models.Case
            m.find data.subject_id
            $.magnificPopup.close()
    )

  deleteDocument: (data) ->
    $(document.body).off 'click', '#popup-confirm-yes'
    $(document.body).on 'click', '#popup-confirm-yes', (e) ->
      e.preventDefault()
      m = new App.Models.Document
      m.destroy data.document_id
      $.magnificPopup.close()
