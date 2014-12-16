class App.Views.Popup.Case

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    App.Vent.subscribe 'popup:cases:new', @newCaseForm
    App.Vent.subscribe 'popup:cases:edit', @editCaseForm
    App.Vent.subscribe 'popup:cases:delete', @deleteCaseForm
    App.Vent.subscribe 'model:cases:create:error', @caseError
    App.Vent.subscribe 'model:cases:update:error', @caseError

  casetype: (casetype = '') ->
    types = ['RFA','NFI','RFC','Info']
    html = ''
    for type, i in types
      checked = if type is casetype or casetype.length is 0 and i is 0 then "checked='checked'" else ''
      html += "
        <div class='case-type-button'>
          <input id='#{type}' type='radio' name='subject[casetype]' value='#{type}' #{checked}><br>
          <label for='#{type}'>#{type}</label>
        </div>
      "
    return html

  casestatus: (casestatus = '') ->
    stati = ['Open', 'In progress', 'Closed']
    html = ''
    for status, i in stati
      checked = if status is casestatus or casestatus.length is 0 and i is 0 then "checked='checked'" else ''
      html += "
        <div class='case-status-button'>
          <input id='#{status}' type='radio' name='subject[status]' value='#{status}' #{checked}>
          <label for='#{status}'>#{status}</label>
        </div>
      "
    return html


  newCaseForm: (data) =>
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
          <div class='box-cell-wrapper' id='subject_title'>
            <input class='inputfield' type='text' name='subject[title]' placeholder='Case name'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='case-type-wrapper'>
              <div class='step-title'>
                What is the status of the case?
              </div>
              #{@casetype()}
            </div>
            <div class='line'></div>
            <div class='case-status-wrapper'>
              <div class='step-title'>
                What status is the Case?
              </div>
              #{@casestatus()}
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


  caseError: (data) ->
    $('.error-message-form').remove()
    $('.inputfield-error').removeClass 'inputfield-error'
    for key, value of data.errors
      if key == 'title'
        $subjectTitle = $('#subject_title')
        $subjectTitle.find('input').addClass 'inputfield-error'
        $subjectTitle.append "<div class='error-message-form'>#{value}</div>"

  editCaseForm: (data) =>
    html = "
    <div class='box-wrapper'>
      <form id='form-case-edit' action='#{App.ApiLocation}cases/#{data.case_id}' method='post'>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='box-title'>
              EDIT CASE
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
          <div class='box-cell-wrapper' id='subject_title'>
            <input class='inputfield' type='text' name='subject[title]' placeholder='Case name' value='#{data.case_title}'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='case-type-wrapper'>
              <div class='step-title'>
                What is the status of the case?
              </div>
              #{@casetype data.case_type}
            </div>
            <div class='line'></div>
            <div class='case-status-wrapper'>
              <div class='step-title'>
                What status is the Case?
              </div>
              #{@casestatus data.case_status}
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <input type='hidden' name='_method' value='put'>
            <input type='submit' value='EDIT' class='green-button-square'>
          </div>
        </div>
      </form>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:cases:edit', data
    App.Vent.publish 'popup:show:inline'

  deleteCaseForm: (data) ->
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
