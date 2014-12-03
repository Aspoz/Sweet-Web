class App.Util.Router

  constructor: () ->
    @childViews = []

  start: ->
    routie(
      '': () ->
        App.Vent.publish 'template', 'home'

      '/cases': =>
        App.Vent.publish 'template', 'list'
        model = new App.Models.Case
        view = new App.Views.CaseIndex
        @childViews.push(view)
        model.all()

      '/cases/:id': (id) =>
        App.Vent.publish 'template', 'list'
        model = new App.Models.Case
        view = new App.Views.CaseShow
        @childViews.push(view)
        model.find(id)
    )
