class App.Views.List
  regions:
    breadcrumbs: $("#jst-list .breadcrumb")
    buttons: $("#jst-list .button-wrapper")
    heading: $("#jst-list .listheading")
    list: $("#jst-list .doc-list")

  constructor: ->
    $(document.body).off 'click', '.case'
    $(document.body).on 'click', '.case', (e) ->
      console.log 'hallo'
      $('.case.highlight').removeClass('highlight')
      $(this).addClass('highlight')
