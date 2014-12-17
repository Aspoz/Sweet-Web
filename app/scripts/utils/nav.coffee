class App.Util.Nav

  constructor: ->
    $(window).on 'hashchange', @activeState
    $(window).on 'load', @activeState
    @activeState()

  activeState: ->
    hash = window.location.hash
    $(".nav a").each (i, e) ->
      regex = new RegExp("^#{e.hash}");
      if regex.test hash
        $('.nav .active').removeClass 'active'
        $(this).addClass 'active'
