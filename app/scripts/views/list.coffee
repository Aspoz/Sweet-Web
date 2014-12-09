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
