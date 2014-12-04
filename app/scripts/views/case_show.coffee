class App.Views.CaseShow extends App.Views.List

  constructor: () ->
    App.Vent.subscribe 'model:cases:find', @render
    App.Vent.subscribe 'cases:show:prepend', @prependItem
    App.Vent.subscribe 'view:list:btns', @editDeleteButtons
    App.Vent.subscribe 'view:list:btns:remove', @editDeleteButtonsDelete
    super()

  debug: (a) ->
    console.log a

  render: (data) =>
    @renderHeading()
    @renderList(data)
    @renderBreadcrumbs(data)
    @renderButtonNew(data)

  listItem: (item) ->
    created_at = moment(item.created_at).format('DD MMM. YYYY')
    li = "
      <li class='case' data-id='#{item.id}'>
        <div class='case-name'><a href='//#{item.attachment_url}' target='blank'>#{item.attachment_file_name}</a></div>
        <div class='case-type'>#{item.attachment_content_type}</div>
        <div class='case-status'>#{created_at}</div>
      </li>
      "
    return li

  renderList: (data) =>
    li = ''
    for item in data._links.documents
      li += @listItem item
    @regions.list.html("<ul>#{li}</ul>")

  prependItem: (data) =>
    @regions.list.find('ul').prepend(@listItem data)

  renderHeading: ->
    html = "
      <div class='case-name-head'>Name</div>
      <div class='case-type-head'>Type</div>
      <div class='case-status-head'>Date</div>
    "
    @regions.heading.html(html)

  renderBreadcrumbs: (data) ->
    breadcrumb = [
      {'title': 'All Cases', 'href': '#/cases'}
      {'title': data.title, 'href': "#/cases/#{data.id}"}
    ]
    view = App.Views.Breadcrumbs(breadcrumb)
    @regions.breadcrumbs.html(view)

  editDeleteButtons: (data) =>
    @renderButtonEdit(data)
    @renderButtonDelete(data)

  editDeleteButtonsDelete: () =>
    @regions.buttons.edit.html('')
    @regions.buttons.delete.html('')

  renderButtonNew: (data) ->
    html = "<a class='popup-inline' data-subject_id='#{data.id}' href='#/documents/new'>abc</a>"
    @regions.buttons.new.html(html)

  renderButtonEdit: (data) ->
    html = "<a class='popup-inline' data-subject_id='#{data.id}' href='#/documents/edit'>abc</a>"
    @regions.buttons.edit.html(html)

  renderButtonDelete: (data) ->
    html = "<a class='popup-inline' data-subject_id='#{data.id}' href='#/documents/delete'>abc</a>"
    @regions.buttons.delete.html(html)
