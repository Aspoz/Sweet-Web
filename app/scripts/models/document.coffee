class App.Models.Document

  urlRoot: App.ApiLocation + 'documents/'

  all: ->
    $.ajax(
      url: @urlRoot
      type: 'GET'
      dataType: 'json'
    )
    .done( (data) ->
      console.log data
    )
    .fail (jqXHR, textStatus, errorThrown) ->
      console.log 'Request failed: ' + textStatus
