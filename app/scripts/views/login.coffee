class App.Views.Login

  regions:
    wrap: $('.login-wrap')

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    @events.push App.Vent.subscribe 'model:sessions:create', @logIn

  render: =>
    html = "
    <div class='box-row-wrapper'>
      <div class='box-cell-wrapper'>
        <img class='grey-logo' alt='Nederlandse Aardolie Maatschappij' src='images/nam-logo-grey.png'>
      </div>
    </div>

    <form id='form-login' method='post' action='#{App.ApiLocation}sessions'>
      <p>
        <input class='inputfield' type='text' name='email' value='' placeholder='Username or Email'>
      </p>
      <p>
        <input class='inputfield' type='password' name='password' value='' placeholder='Password'>
      </p>
      <p class='error-message-login'></p>
      <!--<p><a href='forgot-password.html'>Forgot password?</a></p>-->
      <p><input type='submit' name='commit' value='LOGIN' class='blue-large-button-square'></p>
    </form>
    "

    @regions.wrap.html(html)
    App.Vent.publish 'template:spinner:hide'
    App.Vent.publish 'form:sessions:new'

  logIn: (data) =>
    if data.success
      if data.group_id == 1
        App.Session.authToken = data.access_token
        App.Session.isLoggedIn = true
        routie '/cases'
    else
      message = @regions.wrap.find '.error-message-login'
      input = @regions.wrap.find '.inputfield'
      message.empty()
      input.addClass 'inputfield-error'
      for error in data.errors
        html = "<p>* #{error}</p>"
        message.append(html)
