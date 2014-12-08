class App.Util.Router

  start: ->
    routie(
      '': () ->
        App.Vent.publish 'template', { template: 'login', page: 'login' }

      '/cases': =>
        App.Vent.publish 'template', { template: 'list', page: 'app' }
        model = new App.Models.Case
        view = new App.Views.CaseIndex
        model.all()

      '/cases/:id': (id) =>
        App.Vent.publish 'template', { template: 'list', page: 'app' }
        model = new App.Models.Case
        view = new App.Views.CaseShow
        model.find(id)
    )
