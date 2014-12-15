class App.Views.Popup

  constructor: () ->
    App.Vent.subscribe 'popup:documents:new', @newDocument
    App.Vent.subscribe 'popup:documents:delete', @deleteDocument
    App.Vent.subscribe 'popup:cases:new', @newCase
    App.Vent.subscribe 'popup:cases:delete', @deleteCase
    App.Vent.subscribe 'popup:users:new', @newUser
    App.Vent.subscribe 'popup:users:delete', @deleteUser

    App.Vent.subscribe 'model:cases:create:error', @newCaseError
    App.Vent.subscribe 'model:users:create:error', @newUserError

  newDocument: (data) ->
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
            <div class='dz-message'>Drag &amp; Drop your file(s) or select it from a directory</div>
            <button class='green-button-square btn-upload' type='submit'>UPLOAD</button>
          </form>
        </div>
      </div>
    </div>
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


  newUser: (data) ->
    html = "
    <div class='box-wrapper'>
      <form id='form-user-new' action='#{App.ApiLocation}users' method='post'>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='box-title'>
              ADD USER
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper' id='user_name'>
            <input class='inputfield' type='text' name='user[name]' placeholder='Name'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper' id='user_email'>
            <input class='inputfield' type='text' name='user[email]' placeholder='E-mail'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='step-title'>
              Password must contain aleast 6 characters with one lower case letter, one upper case letter and one digit or symbol
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper' id='user_password'>
            <input class='inputfield' type='password' name='user[password]' placeholder='Password'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper' id='user_password_confirmation'>
            <input class='inputfield' type='password' name='user[password_confirmation]' placeholder='Repeat password'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <input type='hidden' name='user[group_id]' value='0'>
            <input type='submit' value='CREATE' class='green-button-square'>
          </div>
        </div>
      </form>
    </div>
    "
    $('#jst-popup').html(html)

    App.Vent.publish 'form:users:new', data
    App.Vent.publish 'popup:show:inline'


  newUserError: (data) ->
    $('.error-message-form').remove()
    $('.inputfield-error').removeClass 'inputfield-error'
    for key, value of data.errors
      switch key
        when 'name'
          $div = $('#user_name')
        when 'email'
          $div = $('#user_email')
        when 'password'
          $div = $('#user_password')
        when 'password_confirmation'
          $div = $('#user_password_confirmation')

      $div.find('input').addClass 'inputfield-error'
      $div.append "<div class='error-message-form'>#{value}</div>"


  deleteUser: (data) ->
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
            '#{data.user_name}' <br> Are you sure to delete this user?
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
            <a class='grey-button-square left' id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>CANCEL</a>
            <a class='red-button-square right' id='popup-confirm-yes' href='#/users/delete/yes'>DELETE</a>
        </div>
      </div>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:users:delete', data
    App.Vent.publish 'popup:show:inline'
