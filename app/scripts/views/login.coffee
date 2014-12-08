class App.Views.Login

  regions:
    wrap: $('.login-wrap')

  constructor: ->

  render: =>
    html = "
    <div class='box-row-wrapper'>
      <div class='box-cell-wrapper'>
        <img class='grey-logo' alt='Nederlandse Aardolie Maatschappij' src='./images/nam-logo-grey.png'>
      </div>
    </div>

    <form method='post' action='index.html'>
      <p>
        <input class='inputfield' type='text' name='login' value='' placeholder='Username or Email'>
        <div class='error-message-username'>Oops! The username is not correct, please try again.</div>
      </p>
      <p>
        <input class='inputfield' type='password' name='password' value='' placeholder='Password'>
        <div class='error-message-password'>Oops! The password is not correct, please try again.</div>
      </p>
      <p><a href='forgot-password.html'>Forgot password?</a></p>
      <p><input type='submit' name='commit' value='LOGIN' class='blue-large-button-square'></p>
    </form>
    "

    @regions.wrap.html(html)
