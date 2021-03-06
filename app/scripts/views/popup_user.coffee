class App.Views.Popup.User

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    App.Vent.subscribe 'popup:users:new', @newForm
    App.Vent.subscribe 'popup:users:edit', @editForm
    App.Vent.subscribe 'popup:users:delete', @deleteForm
    App.Vent.subscribe 'model:users:create:error', @showError
    App.Vent.subscribe 'model:users:update:error', @showError

  newForm: (data) ->
    html = "
    <div class='box-wrapper popup-user-wrapper'>
      <form id='form-user-new' action='#{App.Settings.api}users' method='post'>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='box-title box-title-user'>
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
              Password must contain at least 6 characters, one upper case letter and one digit.
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
            <input type='hidden' name='user[group_id]' value='2'>
            <input type='submit' value='ADD USER' class='button-square green-button-square'>
          </div>
        </div>
      </form>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:users:new', data
    App.Vent.publish 'popup:show:inline'

  editForm: (data) ->
    html = "
    <div class='box-wrapper popup-user-wrapper'>
      <form id='form-user-edit' action='#{App.Settings.api}users/#{data.user_id}' method='post'>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='box-title box-title-user'>
              EDIT USER
            </div>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper' id='user_name'>
            <input class='inputfield' type='text' name='user[name]' placeholder='Name' value='#{data.user_name}'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper' id='user_email'>
            <input class='inputfield' type='text' name='user[email]' placeholder='E-mail' value='#{data.user_email}'>
          </div>
        </div>
        <div class='box-row-wrapper'>
          <div class='box-cell-wrapper'>
            <div class='step-title'>
              Password must contain at least 6 characters, one upper case letter and one digit.
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
            <input type='hidden' name='user[group_id]' value='#{data.user_group}'>
            <input type='submit' value='EDIT USER' class='button-square green-button-square'>
          </div>
        </div>
      </form>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:users:edit', data
    App.Vent.publish 'popup:show:inline'


  showError: (data) ->
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


  deleteForm: (data) ->
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
            <a class='button-square grey-button-square' id='popup-confirm-no' href='javascript:$.magnificPopup.close()'>CANCEL</a>
            <a class='button-square red-button-square' id='popup-confirm-yes' href='#/users/delete/yes'>DELETE</a>
        </div>
      </div>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'form:users:delete', data
    App.Vent.publish 'popup:show:inline'
