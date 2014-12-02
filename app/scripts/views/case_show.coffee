class App.Views.CaseShow extends App.Views.List

  constructor: () ->
    App.Vent.subscribe 'model:cases:find', @render
    App.Vent.subscribe 'cases:show:prepend', @prependItem

  render: (data) =>
    @renderHeading()
    @renderList(data)
    @renderBreadcrumbs(data)
    @renderButtons(data)

  listItem: (item) ->
    created_at = moment(item.created_at).format('DD MMM. YYYY')
    li = "
      <li class='case'>
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
    @regions.list.html("<ul class='doc-list'>#{li}</ul>")

  prependItem: (data) =>
    @regions.list.find('.doc-list').prepend(@listItem data)

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

  renderButtons: (data) ->
    html = "
      <div class='button-upload blue-button-round'>
        <a class='popup-inline' data-subject_id='#{data.id}' href='#/documents/new'>abc</a>
      </div>
      <div class='button-edit grey-button-round'></div>
      <div class='button-delete red-button-round'></div>
    "
    @regions.buttons.html(html)
