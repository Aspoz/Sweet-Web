class App.Util.Router

  start: ->
    routie(
      '': () ->
        if App.Session.isLoggedIn
          routie('/cases')
        else
          App.Vent.publish 'template', { template: 'login', page: 'login' }
          view = new App.Views.Login
          view.render()

      '/cases': =>
        if App.Session.isLoggedIn
          App.Vent.publish 'template', { template: 'list', page: 'app' }
          model = new App.Models.Case
          view = new App.Views.CaseIndex
          model.all()
        else
          routie('/')


      '/cases/:id': (id) =>
        if App.Session.isLoggedIn
          App.Vent.publish 'template', { template: 'list', page: 'app' }
          model = new App.Models.Case
          view = new App.Views.CaseShow
          model.find(id)
        else
          routie('/')

      '/users': =>
        if App.Session.isLoggedIn
          App.Vent.publish 'template', { template: 'list', page: 'app' }
          model = new App.Models.User
          view = new App.Views.UserIndex
          model.all()
        else
          routie('/')

      '/logout': =>
        model =  new App.Models.Session
        model.destroy App.Session.authToken
        App.Session = {}
        routie('/')
    )
