routie(
  '': () ->
    console.log 'root'

  '/cases': ->
    App.Vent.publish 'router:cases:index'
    model = new App.Models.Case
    view = new App.Views.Cases
    model.all()

  '/cases/:id': (id) ->
    App.Vent.publish 'router:cases:show', id
    model = new App.Models.Case
    view = new App.Views.Cases
    model.find(id)
)
