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
    App.Vent.subscribe 'popup:cases:delete', @deleteCaseForm
    App.Vent.subscribe 'model:cases:create:error', @newCaseError

  newCaseForm: (data) ->
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
              <div class='case-type-button'>
                <input id='RFA' type='radio' name='subject[casetype]' value='RFA' checked='checked'><br>
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
                <input id='info' type='radio' name='subject[casetype]' value='Info'><br>
                <label for='info'>Info</label>
              </div>
            </div>
            <div class='line'></div>
            <div class='case-status-wrapper'>
              <div class='step-title'>
                What status is the Case?
              </div>
                <div class='case-status-button'>
                <input id='open' type='radio' name='subject[status]' value='Open' checked='checked'>
                <label for='open'>open</label>
              </div>

              <div class='case-status-button'>
                <input id='in-progress' type='radio' name='subject[status]' value='In progress'>
                <label for='in-progress'>in progress</label>
              </div>
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


  newCaseError: (data) ->
    $('.error-message-form').remove()
    $('.inputfield-error').removeClass 'inputfield-error'
    for key, value of data.errors
      if key == 'title'
        $subjectTitle = $('#subject_title')
        $subjectTitle.find('input').addClass 'inputfield-error'
        $subjectTitle.append "<div class='error-message-form'>#{value}</div>"

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
