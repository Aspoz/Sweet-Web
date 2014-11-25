class App.Views.Breadcrumbs
  constructor: (data) ->
    a = ''
    for item, i in data
      a += " > " unless i == 0
      a += "<a href='#{item.href}'>#{item.title}</a>"
    return a
