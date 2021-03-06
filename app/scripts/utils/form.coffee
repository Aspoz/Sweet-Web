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
    @events.push App.Vent.subscribe 'form:cases:edit', @editCase
    @events.push App.Vent.subscribe 'form:cases:delete', @deleteCase
    @events.push App.Vent.subscribe 'form:sessions:new', @newSession
    @events.push App.Vent.subscribe 'form:users:new', @newUser
    @events.push App.Vent.subscribe 'form:users:edit', @editUser
    @events.push App.Vent.subscribe 'form:users:delete', @deleteUser

  newDocument: (data) ->
    new Dropzone('#dropzone',
      paramName: 'document[attachment]'
      autoProcessQueue: false
      uploadMultiple: false
      parallelUploads: 10
      maxFiles: 50
      headers:
        "Authorization": "Token token=#{App.Session.authToken}"
      previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"dz-progress\"><span class=\"dz-upload\" data-dz-uploadprogress></span></div>\n  <div class=\"dz-success-mark\"><span>Completed</span></div>\n  <div class=\"dz-error-mark\"><span>✘</span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"

      init: ->
        $(@element).find('button[type=submit]').on 'click', (e) =>
          e.preventDefault()
          e.stopPropagation()
          @processQueue()

        @off 'success'
        @on 'success', (files, response) ->
          App.Vent.publish 'model:documents:create', response

        @off 'error'
        @on 'error', (files, response) ->
          # Gets triggered when there was an error sending the files.
          # Maybe show form again, and notify user of error
          console.log files, response

        @off 'complete'
        @on "complete", (file) ->
          if @getUploadingFiles().length is 0 and @getQueuedFiles().length is 0
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
    App.Vent.subscribe 'model:cases:create', (data) ->
      $.magnificPopup.close()

    $(document.body).off 'submit', '#form-case-new'
    $(document.body).on 'submit', '#form-case-new', (e) ->
      m = new App.Models.Case
      e.preventDefault()
      m.create $(this).serializeObject()

  editCase: (data) ->
    App.Vent.subscribe 'model:cases:update', (data) ->
      $.magnificPopup.close()

    $(document.body).off 'submit', '#form-case-edit'
    $(document.body).on 'submit', '#form-case-edit', (e) ->
      m = new App.Models.Case
      e.preventDefault()
      m.update data.case_id, $(this).serializeObject()

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
      m.create $(this).serializeObject()

  newUser: (data) ->
    App.Vent.subscribe 'model:users:create', (data) ->
      $.magnificPopup.close()

    $(document.body).off 'submit', '#form-user-new'
    $(document.body).on 'submit', '#form-user-new', (e) ->
      m = new App.Models.User
      e.preventDefault()
      m.create $(this).serializeObject()

  editUser: (data) ->
    App.Vent.subscribe 'model:users:update', (data) ->
      $.magnificPopup.close()

    $(document.body).off 'submit', '#form-user-edit'
    $(document.body).on 'submit', '#form-user-edit', (e) ->
      m = new App.Models.User
      e.preventDefault()
      m.update data.user_id, $(this).serializeObject()

  deleteUser: (data) ->
    $(document.body).off 'click', '#popup-confirm-yes'
    $(document.body).on 'click', '#popup-confirm-yes', (e) ->
      e.preventDefault()
      m = new App.Models.User
      m.destroy data.user_id
      $.magnificPopup.close()
