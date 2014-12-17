window.App =
  Models: {}
  Views: {}
  Vent: PubSub
  Util: {}
  Session: {}
  # ApiLocation: 'http://localhost:3000/'
  ApiLocation: 'http://178.62.204.157/'

  initialize: ->
    @cookieHelper()
    @templateEngine()
    @popupHelper()
    @formHelper()
    @setSessionDefaults()
    @router()

  cookieHelper: ->
    c = new App.Util.Cookie

  templateEngine: ->
    t = new App.Util.Template

  popupHelper: ->
    v = new App.Views.Popup
    p = new App.Util.Popup
    p.start()

  formHelper: ->
    f = new App.Util.Form

  setSessionDefaults: ->
    @Session.userId = monster.get 'userId' || 0
    @Session.authToken = monster.get 'authToken' || ''
    @Session.isLoggedIn = monster.get 'isLoggedIn' || false

  router: ->
    r = new App.Util.Router
    r.start()

$ ->
  App.initialize()
