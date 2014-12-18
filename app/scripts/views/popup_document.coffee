class App.Views.Popup.Document

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    App.Vent.subscribe 'popup:documents:new', @newDocumentForm
    App.Vent.subscribe 'popup:documents:delete', @deleteDocumentForm

  newDocumentForm: (data) ->
    html = "
    <div class='box-wrapper'>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='box-title'>
            UPLOAD FILES
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <form id='dropzone' action='#{App.ApiLocation}documents' method='post'>
            <input type='hidden' name='document[subject_id]' value='#{data.subject_id}' />
            <input type='hidden' name='user_id' value='#{App.Session.userId}' />
            <div class='dz-message'>Drag &amp; Drop your PDF file(s) or select it from a directory</div>
            <button class='button-square green-button-square btn-upload' type='submit'>UPLOAD</button>
          </form>
        </div>
      </div>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:documents:new', data
    App.Vent.publish 'popup:show:inline'

  deleteDocumentForm: (data) ->
    html = "
    <div class='box-wrapper'>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='box-title'>
            DELETE CASE
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='step-title'>
            '#{data.document_name}' <br> Are you sure to delete this item?
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
            <a class='grey-button-square' id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>CANCEL</a>
            <a class='red-button-square' id='popup-confirm-yes' href='#/documents/delete/yes'>DELETE</a>
        </div>
      </div>
    </div>"
    $('#jst-popup').html(html)
    App.Vent.publish 'form:document:delete', data
    App.Vent.publish 'popup:show:inline'
