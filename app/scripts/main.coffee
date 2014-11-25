window.App =
  Models: {}
  Views: {}
  Vent: PubSub
  Util: {}
  # ApiLocation: 'http://localhost:3001/'
  ApiLocation: 'http://178.62.204.157/'

  initialize: ->
    new App.Util.Template()
    r = new App.Util.Router
    r.start()

$ ->
  App.initialize()
