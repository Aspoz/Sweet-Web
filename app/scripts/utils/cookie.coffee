class App.Util.Cookie

  constructor: () ->
    App.Vent.subscribe 'cookie:set:sessions', @setSessions
    App.Vent.subscribe 'cookie:delete:sessions', @destroySessions

  setSessions: (data) ->
    for key,value of data
      monster.set key, value, 7

  destroySessions: ->
    for key, value of App.Session
      monster.remove key
    App.Session = {}
