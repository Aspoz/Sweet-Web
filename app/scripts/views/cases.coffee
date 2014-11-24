class App.Views.Cases
  constructor: () ->
    App.Vent.subscribe 'model:cases:all', @index
    App.Vent.subscribe 'model:cases:find', @show

  heading:
    "
      <div class='listheading'>
        <div class='case-name-head'>Name</div>
        <div class='case-type-head'>Type</div>
        <div class='case-status-head'>Status</div>
      </div>
    "

  buttons:
    '
      <div class="button-wrapper">
        <div class="button-upload blue-button-round"></div>
        <div class="button-edit grey-button-round"></div>
        <div class="button-delete red-button-round"></div>
      </div>
      <div class="clear"></div>
    '

  breadcrumbs: (data) ->
    a = ''
    for item, i in data
      a += " > " unless i == 0
      a += "<a href='#{item.href}'>#{item.title}</a>"

    "<div class='breadcrumb'>#{a}</div>"

  index: (data) =>
    breadcrumb = [{'title':'All Cases','href': '#/cases'}]
    li = ''
    for item in data
      li += [
            '<li class="case">',
              '<div class="case-name"><a href="#/cases/',item.id,'">',item.title,'</a></div>',
              '<div class="case-type">',item.casetype,'</div>',
              '<div class="case-status">',item.status,'</div>',
            '</li>'
            ].join ''
    $('.main').html("#{@breadcrumbs breadcrumb}#{@buttons}#{@heading}<ul class='doc-list'>#{li}</ul>")

  show: (data) =>
    breadcrumb = [{'title':'All Cases','href': '#/cases'},{'title':data.title,'href': "#/cases/#{data.id}"}]

    li = ''
    for item in data._links.documents
      li += [
            '<li class="case">',
              '<div class="case-name"><a href="',item.url,'" target="_blank">',item.title,'</a></div>',
              '<div class="case-type">',item.casetype,'</div>',
              '<div class="case-status">',item.status,'</div>',
            '</li>'
            ].join ''
    $('.main').html("#{@breadcrumbs breadcrumb}#{@buttons}#{@heading}<ul class='doc-list'>#{li}</ul>")
