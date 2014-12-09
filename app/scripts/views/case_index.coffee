class App.Views.CaseIndex extends App.Views.List

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()
    super()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    @events.push App.Vent.subscribe 'model:cases:all', @render
    @events.push App.Vent.subscribe 'model:cases:create', @prependItem
    @events.push App.Vent.subscribe 'model:cases:destroy', @removeItem
    @events.push App.Vent.subscribe 'view:list:btns', @editDeleteButtons
    @events.push App.Vent.subscribe 'view:list:btns:remove', @editDeleteButtonsDelete

  render: (data) =>
    @renderHeading()
    @renderList(data)
    @renderBreadcrumbs()
    @renderButtonNew(data)
    @editDeleteButtonsDelete()

  listItem: (item) ->
    li = "
      <li class='case' data-id='#{item.id}' data-title='#{item.title}'>
        <div class='case-name'><a href='#/cases/#{item.id}'>#{item.title}</a></div>
        <div class='case-type'>#{item.casetype}</div>
        <div class='case-status'>#{item.status}</div>
      </li>
      "
    return li

  renderList: (data) =>
    li = ''
    for item in data
      li += @listItem item
    @regions.list.html("<ul>#{li}</ul>")

  prependItem: (data) =>
    @regions.list.find('ul').prepend(@listItem data)

  renderHeading: ->
    html = "
      <div class='case-name-head'>Name</div>
      <div class='case-type-head'>Type</div>
      <div class='case-status-head'>Status</div>
    "
    @regions.heading.html(html)

  renderBreadcrumbs: ->
    breadcrumb = [{'title':'All Cases','href': '#/cases'}]
    view = App.Views.Breadcrumbs(breadcrumb)
    @regions.breadcrumbs.html(view)

  editDeleteButtons: (data) =>
    @renderButtonEdit(data)
    @renderButtonDelete(data)

  editDeleteButtonsDelete: () =>
    @regions.buttons.edit.html('')
    @regions.buttons.delete.html('')

  renderButtonNew: (data) ->
    html = "<a class='popup-inline' href='#/cases/new'><img src='./images/button-add.png' alt=''></a>"
    @regions.buttons.new.html(html)

  renderButtonEdit: (data) ->
    html = "<a class='popup-inline' data-case_id='#{data.id}' data-case_title='#{data.title}' href='#/cases/edit'><img src='./images/button-edit.png' alt=''></a>"
    @regions.buttons.edit.html(html)

  renderButtonDelete: (data) ->
    html = "<a class='popup-inline' data-case_id='#{data.id}' data-case_title='#{data.title}' href='#/cases/delete'><img src='./images/button-delete.png' alt=''></a>"
    @regions.buttons.delete.html(html)

  removeItem: (data) ->
    $(".case[data-id=#{data.id}]").fadeOut(300)
