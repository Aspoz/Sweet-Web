class App.Util.Template
  spinner:
    wrapper: $('.preloader')
    message: $('.preloader').find('span')


  constructor: ->
    App.Vent.subscribe 'template', @switchTemplate
    App.Vent.subscribe 'template:spinner:show', @showLoadingSpinner
    App.Vent.subscribe 'template:spinner:hide', @hideLoadingSpinner

  switchTemplate: (data) =>
    $('.jsp').removeClass('jsp-active')
    $("#jsp-#{data.page}").addClass('jsp-active')

    $('.jst').removeClass('jst-active')
    $("#jst-#{data.template}").addClass('jst-active')

  showLoadingSpinner: () =>
    @timeoutID = window.setTimeout(=>
      @spinner.wrapper.stop(true, true).fadeIn()
    , 1000)

  hideLoadingSpinner: () =>
    window.clearTimeout @timeoutID
    @spinner.wrapper.stop(true, true).fadeOut(200)
