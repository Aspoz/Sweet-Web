class App.Util.Template
  constructor: ->
    App.Vent.subscribe 'template', @switchTemplate

  switchTemplate: (id) ->
    $('.jst').removeClass('jst-active')
    $("#jst-#{id}").addClass('jst-active')
