window.App =
  Models: {}
  Views: {}
  Vent: PubSub
  Util: {}
  # ApiLocation: 'http://localhost:3000/'
  ApiLocation: 'http://178.62.204.157/'

  initialize: ->
    @templateEngine()
    @popupHelper()
    @formHelper()
    @router()

  templateEngine: ->
    t = new App.Util.Template

  popupHelper: ->
    v = new App.Views.Popup
    p = new App.Util.Popup
    p.start()

  formHelper: ->
    f = new App.Util.Form

  router: ->
    r = new App.Util.Router
    r.start()

$ ->
  App.initialize()
