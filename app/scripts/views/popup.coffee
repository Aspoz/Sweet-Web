class App.Views.Popup

  constructor: () ->
    App.Vent.subscribe 'popup:documents:new', @newDocument
    App.Vent.subscribe 'popup:documents:delete', @deleteDocument
    App.Vent.subscribe 'popup:cases:new', @newCase
    App.Vent.subscribe 'popup:cases:delete', @deleteCase

  newDocument: (data) ->
    html = "
    <h2>Upload file</h2>
    <hr/>
    <form id='dropzone' action='#{App.ApiLocation}documents' method='post'>
      <input type='hidden' name='document[subject_id]' value='#{data.subject_id}' />
      <div class='dz-message' style='cursor:pointer;'>Drop files here to upload</div>
      <button type='submit'>Upload</button>
    </form>
    "
    $('#jst-popup').html(html)

    App.Vent.publish 'form:documents:new', data
    App.Vent.publish 'popup:show:inline'

  deleteDocument: (data) ->
    html = "
    <h2>Delete Document</h2>
    <p>Are you sure you want to delete '#{data.document_name}'</p>
    <p>
      <a id='popup-confirm-yes' href='#/documents/delete/yes'>Yes</a> |
      <a id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>No</a>
    </p>

    "
    $('#jst-popup').html(html)

    App.Vent.publish 'form:documents:delete', data
    App.Vent.publish 'popup:show:inline'

  newCase: (data) ->
    html = "
    <h2>New Case</h2>
    <hr/>
    <form id='form-case-new' action='#{App.ApiLocation}cases' method='post'>
      <input type='text' name='subject[title]' placeholder='title' />
      <input type='text' name='subject[status]' placeholder='status' />
      <input type='text' name='subject[casetype]' placeholder='type' />
      <button type='submit'>New</button>
    </form>
    "
    $('#jst-popup').html(html)

    App.Vent.publish 'form:cases:new', data
    App.Vent.publish 'popup:show:inline'


  deleteCase: (data) ->
    html = "
    <h2>Delete Case</h2>
    <p>Are you sure you want to delete '#{data.case_title}'</p>
    <p>
      <a id='popup-confirm-yes' href='#/cases/delete/yes'>Yes</a> |
      <a id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>No</a>
    </p>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:cases:delete', data
    App.Vent.publish 'popup:show:inline'
