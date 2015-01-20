class App.Views.Popup.ServerError

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    App.Vent.subscribe 'popup:errors:server', @render

  render: () ->
    html = "
    <div class='box-wrapper'>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='box-title'>
            INTERNAL SERVER ERROR
          </div>
        </div>
      </div>
      <div class='box-row-wrapper'>
        <div class='box-cell-wrapper'>
          <div class='step-title' style='width:500px;'>
            The server encountered an internal error or misconfiguration and was unable to complete your request.
            Please contact the server administrator, <a href='mailto:#{App.Settings.email}'>#{App.Settings.email}</a> and inform them of the time the error occurred, and anything you might have done that may have caused the error.
          </div>
        </div>
      </div>
    </div>
    "
    $('#jst-popup').html(html)
    App.Vent.publish 'popup:show:inline'
