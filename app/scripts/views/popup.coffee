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
            <a class='grey-button-square left' id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>CANCEL</a>
            <a class='red-button-square right' id='popup-confirm-yes' href='#/documents/delete/yes'>DELETE</a>
        </div>
      </div>
    </div>"
    $('#jst-popup').html(html)

    App.Vent.publish 'form:documents:delete', data
    App.Vent.publish 'popup:show:inline'

  newCase: (data) ->
    html = "
    <div class='box-wrapper'>
      <form id='form-case-new' action='#{App.ApiLocation}cases' method='post'>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='box-title'>
              ADD CASE
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='step-title'>
              What is the name of the Case?
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <input class='inputfield' type='text' name='subject[title]' value='' placeholder='Case name'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='step-title'>
              What type is the Case?
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='case-type-button'>
              <input id='RFA' type='radio' name='subject[casetype]' value='RFA'><br>
              <label for='RFA'>RFA</label>
            </div>
            <div class='case-type-button'>
              <input id='NFI' type='radio' name='subject[casetype]' value='NFI'><br>
              <label for='NFI'>NFI</label>
            </div>
            <div class='case-type-button'>
              <input id='RFC' type='radio' name='subject[casetype]' value='RFC'><br>
              <label for='RFC'>RFC</label>
            </div>
            <div class='case-type-button'>
              <input id='info' type='radio' name='subject[casetype]' value='info'><br>
              <label for='info'>info</label>
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='step-title'>
              What status is the Case?
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='case-status-button'>
              <input id='open' type='radio' name='subject[status]' value='Open'>
              <label for='open'>Open</label>
            </div>

            <div class='case-status-button'>
              <input id='in-progress' type='radio' name='subject[status]' value='In progress'>
              <label for='in-progress'>In progress</label>
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <input type='submit' value='CREATE' class='green-button-square'>
          </div>
        </div>
      </form>
    </div>
    "
    $('#jst-popup').html(html)

    App.Vent.publish 'form:cases:new', data
    App.Vent.publish 'popup:show:inline'


  deleteCase: (data) ->
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
            '#{data.case_title}' <br> Are you sure to delete this item?
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
            <a class='grey-button-square left' id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>CANCEL</a>
            <a class='red-button-square right' id='popup-confirm-yes' href='#/cases/delete/yes'>DELETE</a>
        </div>
      </div>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:cases:delete', data
    App.Vent.publish 'popup:show:inline'
