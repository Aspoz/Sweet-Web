class App.Views.CaseShow extends App.Views.List

  events: []

  constructor: () ->
    @removeListeners()
    @addListeners()
    super()

  removeListeners: () ->
    @events.forEach (e) ->
      App.Vent.unsubscribe e

  addListeners: () ->
    @events.push App.Vent.subscribe 'model:cases:find', @render
    @events.push App.Vent.subscribe 'model:documents:create', @prependItem
    @events.push App.Vent.subscribe 'model:documents:destroy', @removeItem
    @events.push App.Vent.subscribe 'view:list:btns', @editDeleteButtons
    @events.push App.Vent.subscribe 'view:list:btns:remove', @editDeleteButtonsDelete

  render: (data) =>
    @renderHeading()
    @renderList(data._links.documents)
    @renderBreadcrumbs(data)
    @renderButtonNew(data)
    @editDeleteButtonsDelete()

  listItem: (item) ->
    created_at = moment(item.created_at).format('DD MMM. YYYY')
    li = "
      <li class='case' data-id='#{item.id}' data-name='#{item.attachment_file_name}'>
        <div class='case-name'><img src='images/document.png' alt='pdf'><a class='popup-iframe' href='//#{item.attachment_url}' target='blank'>#{item.attachment_file_name}</a></div>
        <div class='case-type'>#{item.attachment_content_type}</div>
        <div class='case-status'>#{created_at}</div>
      </li>
      "
    li

  empty: (subject_id) ->
    "
      <div class='view-empty'>
        <p>No Files have been added to this case.</p>
        <p><a class='popup-inline button-square blue-button-square' data-subject_id='#{subject_id}' href='#/documents/new'>Add Files</a></p>
      </div>
    "

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
    html = "<a title='New Document' class='button-upload blue-button-round popup-inline' data-subject_id='#{data.id}' href='#/documents/new'><img src='images/button-add.png' alt=''></a>"
    @regions.buttons.new.html(html)

  renderButtonEdit: (data) ->
    # Print empty string to DOM so edit button for documents isn't shown
    # html = "<a title='Edit Document' class='button-edit grey-button-round popup-inline' data-document_id='#{data.id}' data-document_name='#{data.name}' href='#/documents/edit'><img src='images/button-edit.png' alt=''></a>"
    # @regions.buttons.edit.html(html)
    @regions.buttons.edit.html('')

  renderButtonDelete: (data) ->
    html = "<a title='Delete Document' class='button-delete red-button-round popup-inline' data-document_id='#{data.id}' data-document_name='#{data.name}' href='#/documents/delete'><img src='images/button-delete.png' alt=''></a>"
    @regions.buttons.delete.html(html)
