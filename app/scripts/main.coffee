
window.App =
  Models: {}
  # ApiLocation: 'http://localhost:3000/'
  ApiLocation: 'http://178.62.204.157/api/'

  initialize: ->
    console.log "'Allo from CoffeeScript!"


$ ->
  App.initialize()
