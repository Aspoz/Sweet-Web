
window.App =
  Models: {}
  Vent: PubSub
  # ApiLocation: 'http://localhost:3001/'
  ApiLocation: 'http://178.62.204.157/api/'

  initialize: ->
    console.log "'Allo from CoffeeScript!"


$ ->
  App.initialize()
