class App.Views.Popup.NoInternet

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    App.Vent.subscribe 'popup:internet:nope', @render

  render: () ->
    html = "
    <div class='box-wrapper'>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='box-title'>
            NO INTERNET CONNECTION
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='step-title'>
            Sory you are not connected to the internet! <br/>
            Please re-connect with a stable connection to access the app
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
            <a class='button-square grey-button-square' href='javascript:location.reload();'>TRY RE-CONNECTING</a>
        </div>
      </div>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'popup:show:inline'
