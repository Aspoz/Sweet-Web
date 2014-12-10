class App.Util.Form

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    @events.push App.Vent.subscribe 'form:documents:new', @newDocument
    @events.push App.Vent.subscribe 'form:documents:delete', @deleteDocument
    @events.push App.Vent.subscribe 'form:cases:new', @newCase
    @events.push App.Vent.subscribe 'form:cases:delete', @deleteCase
    @events.push App.Vent.subscribe 'form:sessions:new', @newSession
    @events.push App.Vent.subscribe 'form:users:new', @newUser

  newDocument: (data) ->
    new Dropzone('#dropzone',
      paramName: 'document[attachment]'
      autoProcessQueue: false
      uploadMultiple: false
      parallelUploads: 10
      maxFiles: 50

      init: ->
        $(@element).find('button[type=submit]').on 'click', (e) =>
          e.preventDefault()
          e.stopPropagation()
          @processQueue()

        @on 'sending', ->
          # Gets triggered when the form is actually being sent.
          # Hide the success button or the complete form.

        @off 'success'
        @on 'success', (files, response) ->
          App.Vent.publish 'model:documents:create', response

        @on 'error', (files, response) ->
          # Gets triggered when there was an error sending the files.
          # Maybe show form again, and notify user of error
          console.log files, response

        @on "complete", (file) ->
           if @getUploadingFiles().length is 0 and @getQueuedFiles().length is 0
            # m = new App.Models.Case
            # m.find data.subject_id
            $.magnificPopup.close()
    )

  deleteDocument: (data) ->
    $(document.body).off 'click', '#popup-confirm-yes'
    $(document.body).on 'click', '#popup-confirm-yes', (e) ->
      e.preventDefault()
      m = new App.Models.Document
      m.destroy data.document_id
      $.magnificPopup.close()

  newCase: (data) ->
    $(document.body).off 'submit', '#form-case-new'
    $(document.body).on 'submit', '#form-case-new', (e) ->
      m = new App.Models.Case
      e.preventDefault()
      m.create $(this).serialize()
      $.magnificPopup.close()

  deleteCase: (data) ->
    $(document.body).off 'click', '#popup-confirm-yes'
    $(document.body).on 'click', '#popup-confirm-yes', (e) ->
      e.preventDefault()
      m = new App.Models.Case
      m.destroy data.case_id
      $.magnificPopup.close()

  newSession: () ->
    $(document.body).off 'submit', '#form-login'
    $(document.body).on 'submit', '#form-login', (e) ->
      e.preventDefault()
      m = new App.Models.Session
      m.create $(this).serialize()

  newUser: (data) ->
    $(document.body).off 'submit', '#form-user-new'
    $(document.body).on 'submit', '#form-user-new', (e) ->
      m = new App.Models.User
      e.preventDefault()
      m.create $(this).serialize()
      $.magnificPopup.close()
