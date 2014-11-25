class App.Views.CaseShow extends App.Views.List

  constructor: () ->
    App.Vent.subscribe 'model:cases:find', @render

  render: (data) =>
    @renderHeading()
    @renderList(data)
    @renderBreadcrumbs(data)
    @renderButtons()

  renderList: (data) ->
    li = ''
    for item in data._links.documents
      created_at = moment(item.created_at).format('DD MMM. YYYY')
      li += "
        <li class='case'>
          <div class='case-name'><a href='#{App.ApiLocation}#{item.attachment_url}' target='blank'>#{item.title}</a></div>
          <div class='case-type'>#{item.attachment_content_type}</div>
          <div class='case-status'>#{created_at}</div>
        </li>
        "
    @regions.list.html("<ul class='doc-list'>#{li}</ul>")

  renderHeading: ->
    html = "
      <div class='case-name-head'>Name</div>
      <div class='case-type-head'>Type</div>
      <div class='case-status-head'>Date</div>
    "
    @regions.heading.html(html)

  renderBreadcrumbs: (data)->
    breadcrumb = [
      {'title': 'All Cases', 'href': '#/cases'}
      {'title': data.title, 'href': "#/cases/#{data.id}"}
    ]
    view = App.Views.Breadcrumbs(breadcrumb)
    @regions.breadcrumbs.html(view)

  renderButtons: ->
    html = "
      <div class='button-upload blue-button-round'></div>
      <div class='button-edit grey-button-round'></div>
      <div class='button-delete red-button-round'></div>
    "
    @regions.buttons.html(html)
