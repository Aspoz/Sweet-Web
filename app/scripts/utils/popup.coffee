class App.Util.Popup

  constructor: ->
    App.Vent.subscribe 'popup:show:inline', @showInline
    App.Vent.subscribe 'popup:close', @close

  start: =>
    $(document.body).on 'click', '.popup-inline', (e) ->
      e.preventDefault()
      $this = $(this)
      [_,resource,action] = $this.attr('href').split '/'
      App.Vent.publish "popup:#{resource}:#{action}", $this.data()

    $(document.body).on 'click', '.popup-iframe', (e) =>
      e.preventDefault()
      console.log
      @showIframe e.target.href

  showInline: () ->
    $.magnificPopup.open
      items:
        src: '.white-popup'
        type: 'inline'

  showIframe: (src) ->
    $.magnificPopup.open
      items:
        src: src
      type: 'iframe'

  close: () ->
    $.magnificPopup.close()
