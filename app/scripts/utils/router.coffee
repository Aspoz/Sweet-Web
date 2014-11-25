class App.Util.Router

  start: ->
    routie(
      '': () ->
        App.Vent.publish 'template', 'home'

      '/cases': ->
        App.Vent.publish 'template', 'list'
        model = new App.Models.Case
        view = new App.Views.CaseIndex
        model.all()

      '/cases/:id': (id) ->
        App.Vent.publish 'template', 'list'
        model = new App.Models.Case
        view = new App.Views.CaseShow
        model.find(id)
    )
