class App.Views.UserIndex extends App.Views.List

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()
    super()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    @events.push App.Vent.subscribe 'model:users:all', @render
    @events.push App.Vent.subscribe 'model:users:create', @appendItem
    @events.push App.Vent.subscribe 'model:users:update', @updateItem
    @events.push App.Vent.subscribe 'model:users:destroy', @removeItem
    @events.push App.Vent.subscribe 'view:list:btns', @editDeleteButtons
    @events.push App.Vent.subscribe 'view:list:btns:remove', @editDeleteButtonsDelete

  render: (data) =>
    App.Vent.publish 'template:spinner:hide'
    @renderHeading()
    @renderList(data)
    @renderBreadcrumbs()
    @renderButtonNew(data)
    @editDeleteButtonsDelete()

  listItem: (item) ->
    li = "
      <li class='case' data-id='#{item.id}' data-name='#{item.name}' data-email='#{item.email}' data-group='#{item.group_id}'>
        <div class='case-name'><a href='#/users/#{item.id}'>#{item.name}</a></div>
        <div class='case-type'>#{item.email}</div>
        <div class='case-status'>#{item.id}</div>
      </li>
      "
    return li

  renderList: (data) =>
    li = ''
    for item in data
      li += @listItem item
    @regions.list.html("<ul>#{li}</ul>")

  appendItem: (data) =>
    @regions.list.find('ul').append(@listItem data)

  renderHeading: ->
    html = "
      <div class='case-name-head'>Name</div>
      <div class='case-type-head'>E-mail</div>
      <div class='case-status-head'>#</div>
    "
    @regions.heading.html(html)

  renderBreadcrumbs: ->
    breadcrumb = [{'title':'All Users','href': '#/users'}]
    view = App.Views.Breadcrumbs(breadcrumb)
    @regions.breadcrumbs.html(view)

  editDeleteButtons: (data) =>
    @renderButtonEdit(data)
    @renderButtonDelete(data)

  editDeleteButtonsDelete: () =>
    @regions.buttons.edit.html('')
    @regions.buttons.delete.html('')

  renderButtonNew: (data) ->
    html = "<a class='button-upload blue-button-round popup-inline' href='#/users/new'><img src='images/button-add.png' alt=''></a>"
    @regions.buttons.new.html(html)

  renderButtonEdit: (data) ->
    html = "<a class='button-edit grey-button-round popup-inline' data-user_id='#{data.id}' data-user_name='#{data.name}' data-user_email='#{data.email}' data-user_group='#{data.group}' href='#/users/edit'><img src='images/button-edit.png' alt=''></a>"
    @regions.buttons.edit.html(html)

  renderButtonDelete: (data) ->
    html = "<a class='button-delete red-button-round popup-inline' data-user_id='#{data.id}' data-user_name='#{data.name}' href='#/users/delete'><img src='images/button-delete.png' alt=''></a>"
    @regions.buttons.delete.html(html)

  removeItem: (data) ->
    $(".case[data-id=#{data.id}]").fadeOut(200)

  updateItem: (data) =>
    $el = $(".case[data-id=#{data.id}]")
    $el.removeClass 'highlight'
    $el.data 'name', data.name
    $el.data 'email', data.email
    $el.data 'group', data.group_id

    $el.find('.case-name').html("<a href='#/users/#{data.id}'>#{data.name}</a>")
    $el.find('.case-type').html(data.email)
    $el.find('.case-status').html(data.id)
    @editDeleteButtonsDelete()
