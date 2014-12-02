class App.Views.Popup

  constructor: () ->
    App.Vent.subscribe 'popup:documents:new', @newDocument

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

    App.Vent.publish 'form:dropzone:documents', data
    App.Vent.publish 'popup:show:inline'
