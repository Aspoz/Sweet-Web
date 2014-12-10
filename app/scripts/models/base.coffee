class App.Models.Base

  constructor: (@root)->
    @urlRoot =  "#{App.ApiLocation}#{@root}/"

  all: () ->
    $.ajax(
      url: @urlRoot
      type: 'GET'
      dataType: 'json'
      crossDomain: true
    )
    .done( (data, textStatus, jqXHR) =>
      App.Vent.publish "model:#{@root}:all", data
    )
    .fail (jqXHR, textStatus, errorThrown) =>
      App.Vent.publish "model:#{@root}:all:error", jqXHR.responseJSON

  find: (id) ->
    $.ajax(
      url: @urlRoot + id
      type: 'GET'
      dataType: 'json'
      crossDomain: true
    )
    .done( (data) =>
      App.Vent.publish "model:#{@root}:find", data
    )
    .fail (jqXHR, textStatus, errorThrown) =>
      App.Vent.publish "model:#{@root}:find:error", jqXHR.responseJSON

  create: (attr) ->
    $.ajax(
      url: @urlRoot
      type: 'POST'
      dataType: 'json'
      crossDomain: true
      data: attr
    )
    .done( (data) =>
      App.Vent.publish "model:#{@root}:create", data
    )
    .fail (jqXHR, textStatus, errorThrown) =>
      App.Vent.publish "model:#{@root}:create:error", jqXHR.responseJSON

  update: (id, attr) ->
    $.ajax(
      url: @urlRoot + id
      type: 'POST'
      dataType: 'json'
      crossDomain: true
      data:
        _method: 'put'
    )
    .done( (data) =>
      App.Vent.publish "model:#{@root}:update", data
      console.log data
    )
    .fail (jqXHR, textStatus, errorThrown) =>
      App.Vent.publish "model:#{@root}:update:error", jqXHR.responseJSON

  destroy: (id) ->
    $.ajax(
      url: @urlRoot + id
      type: 'POST'
      dataType: 'json'
      crossDomain: true
      data:
        _method: 'delete'
    )
    .done( (data) =>
      App.Vent.publish "model:#{@root}:destroy", id: id
    )
    .fail (jqXHR, textStatus, errorThrown) =>
      App.Vent.publish "model:#{@root}:destroy:error", jqXHR.responseJSON
