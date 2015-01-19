class App.Views.List
  regions:
    breadcrumbs: $("#jst-list .breadcrumb")
    buttons:
      new: $("#jst-list .button-wrapper .new")
      edit: $("#jst-list .button-wrapper .edit")
      delete: $("#jst-list .button-wrapper .delete")
    heading: $("#jst-list .listheading")
    list: $("#jst-list .doc-list")

  constructor: ->
    @caseClickHandler()

  caseClickHandler: () =>
    $(document.body).off 'click', '.case'
    $(document.body).on 'click', '.case', (e) ->
      if !$(e.target).is 'a'
        $this = $(this)
        classname = 'highlight'
        if $this.hasClass classname
          $this.removeClass classname
          App.Vent.publish 'view:list:btns:remove'
        else
          $('.case.highlight').removeClass classname
          $this.addClass 'highlight'
          App.Vent.publish 'view:list:btns', $this.data()
      else
        App.Vent.publish 'view:list:btns:remove'
        return

  renderList: (data) =>
    li = ''
    if data.length > 0
      for item in data
        li += @listItem item
      @regions.list.html("<ul>#{li}</ul>")
    else
      @regions.list.html(@empty)

  prependItem: (data) =>
    ul = @regions.list.find('ul')
    li = @listItem data
    if ul.length is 0
      @regions.list.html("<ul>#{li}</ul>")
    else
      ul.prepend(li)

  appendItem: (data) =>
    ul = @regions.list.find('ul')
    li = @listItem data
    if ul.length is 0
      @regions.list.html("<ul>#{li}</ul>")
    else
      ul.append(li)

  removeItem: (data) ->
    $(".case[data-id=#{data.id}]").fadeOut(200)
