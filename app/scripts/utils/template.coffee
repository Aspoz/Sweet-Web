class App.Util.Template
  constructor: ->
    App.Vent.subscribe 'template', @switchTemplate

  switchTemplate: (data) ->
    $('.jsp').removeClass('jsp-active')
    $("#jsp-#{data.page}").addClass('jsp-active')

    $('.jst').removeClass('jst-active')
    $("#jst-#{data.template}").addClass('jst-active')
