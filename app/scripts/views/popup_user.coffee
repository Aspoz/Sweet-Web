class App.Views.Popup.User

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    App.Vent.subscribe 'popup:users:new', @newUserForm
    App.Vent.subscribe 'popup:users:delete', @deleteUserForm
    App.Vent.subscribe 'model:users:create:error', @newUserError

  newUserForm: (data) ->
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


  deleteUserForm: (data) ->
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
