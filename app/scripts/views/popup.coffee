class App.Views.Popup

  constructor: () ->
    App.Vent.subscribe 'popup:documents:new', @newDocument
    App.Vent.subscribe 'popup:documents:delete', @deleteDocument

  newDocument: (data) ->
    html = "
    <h2>Upload file</h2>
    <hr/>
    <form id='dropzone' action='#{App.ApiLocation}documents'>
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
