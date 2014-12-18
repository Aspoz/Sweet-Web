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
    @events.push App.Vent.subscribe 'model:cases:update', @updateItem
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
      <li class='case' data-id='#{item.id}' data-title='#{item.title}' data-casetype='#{item.casetype}' data-status='#{item.status}'>
        <div class='case-name'><a href='#/cases/#{item.id}'>#{item.title}</a></div>
        <div class='case-type'>#{item.casetype}</div>
        <div class='case-status'>#{item.status}</div>
      </li>
      "
    return li

  renderList: (data) =>
    li = ''
    if data.length > 0
      for item in data
        li += @listItem item
      @regions.list.html("<ul>#{li}</ul>")
    else
      @regions.list.html(@empty)

  empty: (subject_id) ->
    "
      <div class='view-empty'>
        <p>No Cases have been found.</p>
        <p><a class='popup-inline button-square blue-button-square' href='#/cases/new'>Add a Case</a></p>
      </div>
    "

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
    html = "<a title='New Case' class='button-upload blue-button-round popup-inline' href='#/cases/new'><img src='images/button-add.png' alt='add'></a>"
    @regions.buttons.new.html(html)

  renderButtonEdit: (data) ->
    html = "<a title='Edit Case' class='button-edit grey-button-round popup-inline' data-case_id='#{data.id}' data-case_title='#{data.title}' data-case_type='#{data.casetype}' data-case_status='#{data.status}' href='#/cases/edit'><img src='images/button-edit.png' alt=''></a>"
    @regions.buttons.edit.html(html)

  renderButtonDelete: (data) ->
    html = "<a title='Delete Case' class='button-delete red-button-round popup-inline' data-case_id='#{data.id}' data-case_title='#{data.title}' href='#/cases/delete'><img src='images/button-delete.png' alt=''></a>"
    @regions.buttons.delete.html(html)

  removeItem: (data) ->
    $(".case[data-id=#{data.id}]").fadeOut(200)

  updateItem: (data) =>
    $el = $(".case[data-id=#{data.id}]")
    $el.removeClass 'highlight'
    $el.data 'title', data.title
    $el.data 'casetype', data.casetype
    $el.data 'status', data.status

    $el.find('.case-name').html("<a href='#/cases/#{data.id}'>#{data.title}</a>")
    $el.find('.case-type').html(data.casetype)
    $el.find('.case-status').html(data.status)
    @editDeleteButtonsDelete()
