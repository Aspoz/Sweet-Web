class App.Views.CaseIndex extends App.Views.List

  constructor: () ->
    App.Vent.subscribe 'model:cases:all', @render

  render: (data) =>
    @renderHeading()
    @renderList(data)
    @renderBreadcrumbs()
    @renderButtons()

  renderList: (data) ->
    li = ''
    for item in data
      li += "
        <li class='case'>
          <div class='case-name'><a href='#/cases/#{item.id}'>#{item.title}</a></div>
          <div class='case-type'>#{item.casetype}</div>
          <div class='case-status'>#{item.status}</div>
        </li>
        "
    @regions.list.html("<ul class='doc-list'>#{li}</ul>")

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

  renderButtons: ->
    html = "
      <div class='button-upload blue-button-round'></div>
      <div class='button-edit grey-button-round'></div>
      <div class='button-delete red-button-round'></div>
    "
    @regions.buttons.html(html)
