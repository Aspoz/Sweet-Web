# Webapplicatie

The webapplication can be found in the following repostory:
[https://github.com/Aspoz/Sweet-Web]()

## Getting started

To get started you will need the following.  
If you don't have node installed on your system you should do that first. It can be downloaded [here](http://nodejs.org/).  
We will need `grunt` for all the tasks that will be running and `bower` for all the third party packages we will be using.

- Install grunt: `npm install -g grunt-cli`
- Install bower: `npm install -g bower`

After this is done you should go in the projects rootfolder and install all the dependencies.

- Install npm dependencies: `npm install`
- Install bower dependencies: `bower install`

When this is all done we can do `grunt serve` to start a live preview of the project.
When you're all done and want to deploy the project to a live server you can run the following command: `grunt build`, this will concatenate and minify all files.

For more information visit the following [github repository](https://github.com/yeoman/generator-webapp).

## Router

The router is where it all starts, it listens to hashchange and when a route is matched it will dispatch it. The router class is located in `app/scripts/utils`.

The router class is a wrapper around [routie](https://github.com/jgallen23/routie). It has only 1 method which is `start`. When the start method is called it will start the routing process.

##### Small example

    # utils/router.coffee
    class App.Util.Router

      start: ->
        routie(
          '/cases': () =>
          '/cases/:id': (id) =>
        )

### Routes

The current routes that are assigned are `''`, `/cases`, `/cases/:id`, `/users` and `logout`.

Typically what we do when we go to a route we request a template, make a view and make a model which then calls the API.

## Models

Models are used to retrieve data from the API. All models are located in `app/scripts/models`.

Every model extends from the basemodel which has a set of predefined methods which we will discuss in detail below.

### Base

The basemodel requires a resource route wich leads to the API, which will be passed down from the model that will extend this base. Every request that will be made to the API needs an `authToken`, when there isn't one set it will redirect to the login page.

    # models/base.coffee
    class App.Models.Base
      constructor: (@root)->
        @urlRoot =  "#{App.Settings.api}#{@root}/"

The base consist of 5 methods which are the following:

#### all: () ->
It will make a GET request to the API and returns a collection of items.
When it is done it will send out an event with the data attached to `"model:#{@root}:all", data`.
When the request made fails, there will be send out an event with the response from the server to `"model:#{@root}:all:error", jqXHR.responseJSON`.

##### Example

    m =  new App.Models.Case
    m.all()

#### find: (id) ->
It will make a GET request to the API and returns 1 item.
When it is done it will send out an event with the data attached to `"model:#{@root}:find", data`.
When the request made fails, there will be send out an event with the response from the server to `"model:#{@root}:find:error", jqXHR.responseJSON`.

##### Example

    m =  new App.Models.Case
    m.find(1)

#### create: (attr) ->
It will make a POST request to the API and returns the item that was created.
When it is done it will send out an event with the data attached to `"model:#{@root}:create", data`.
When the request made fails, there will be send out an event with the response from the server to `"model:#{@root}:create:error", jqXHR.responseJSON`.

The attributes that need to be included in the method are key/value pairs of the form fields that are submitted.

##### Example

    $(document.body).on 'submit', '#form-case-new', (e) ->
      e.preventDefault()
      m = new App.Models.Case
      m.create $(this).serializeObject()

#### update: (id, attr) ->
It will make a POST request to the API and returns the item that was updated.
When it is done it will send out an event with the data attached to `"model:#{@root}:update", data`.
When the request made fails, there will be send out an event with the response from the server to `"model:#{@root}:update:error", jqXHR.responseJSON`.

The attributes that need to be included in the method are key/value pairs of the form fields that are submitted.

##### Example

    $(document.body).on 'submit', '#form-case-edit', (e) ->
      e.preventDefault()
      m = new App.Models.Case
      m.update case_id, $(this).serializeObject()

#### destroy: (id) ->
It will make a POST request to the API and returns a collection of items.
When it is done it will send out an event with the id attached to `"model:#{@root}:destroy", id`.
When the request made fails, there will be send out an event with the response from the server to `"model:#{@root}:destroy:error", jqXHR.responseJSON`

##### Example

    m =  new App.Models.Case
    m.destroy(1)

### Extending from base

When extending from the base class all that is needed is the location where the resource can be found on the api, relative to the Settings.api.

##### Example
    
    # models/case.coffee
    class App.Models.Case extends App.Models.Base

      root: 'cases'

      constructor: ->
        super(@root)

## Templating

Templating is done through hiding/showing certain html elements. The template class can be found in `app/scripts/utils`.

This class is responsible for the loading spinner and switching pages and templates.
It listens to 3 channels which are: `template`,`template:spinner:show`,`template:spinner:hide`.

When publishing an event to `template` channel there needs to be 2 parameters sent. These parameters are `page` and `template`.

Every template has a class of `.jst` and every page has a class of `.jsp`. The id is used as unique identifier with `jsp-`/`jst-` prepended to it.

##### Example
Here we request the app page with the list template. which will correspond with the following html elements. 

    App.Vent.publish 'template', { template: 'list', page: 'app' }

    # will show the following elements
    <div id="jsp-app" class="jsp">
    <div id="jst-list" class="jst">

## Views

Views can be found in `app/scripts/views`. Views are responsible for most of the interactions with the DOM.

##### Example

In this example we instantiate a view with most of the boilerplate code needed.

    # views/case_index.coffee
    class App.Views.CaseIndex extends App.Views.List

      events: []

      constructor: () ->
        @removeListeners()
        @addListeners()
        super()

      removeListeners: () ->
        @events.forEach (e) ->
          App.Vent.unsubscribe e

      addListeners: () ->
        @events.push App.Vent.subscribe 'model:cases:all', @render
        @events.push App.Vent.subscribe 'model:cases:create', @prependItem
        ...

      render: (data) =>
        @renderHeading()
        @renderList(data)
        ...

The `events` variable is used to store all the listeners of the view.  
On instantiation of the view we first unsubscribe any listerners that are present before we add new listeners.  
When we get a response from the model we call the render method.

### List View

The list view is used for displaying lists of data, which is used to display a list of cases, documents and users.

In this view there are some regions defined.
These regions represend the predefined elements in the list template.

    # views/list.coffee
    regions:
        breadcrumbs: $("#jst-list .breadcrumb")
        buttons:
          new: $("#jst-list .button-wrapper .new")
          edit: $("#jst-list .button-wrapper .edit")
          delete: $("#jst-list .button-wrapper .delete")
        heading: $("#jst-list .listheading")
        list: $("#jst-list .doc-list")

There is also an highlighter present, if someone clicks on a listitem it wil be highlighted but only when it isn't the link to this item. When an item is clicked it will also show the action buttons for this particular item. This is done through publishing an event to `view:list:btns` channel and hiding trough sending an event to `view:list:btns:remove` channel.

    # views/list.coffee
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

### Login View

The Login respresents the view for the form and also handles session creation.

This view listens to `model:sessions:create` channel. This channel is used when there is a session made on the API side. If it was a success we first need to check if the user is authorized, else we will show an error message.
If all went well we set the session variables and cookies.

    # views/login.coffee
    if data.success
          if data.group_id == 1
            App.Session.userId = data.user_id
            App.Session.authToken = data.access_token
            App.Session.isLoggedIn = true
            App.Vent.publish 'cookie:set:sessions', App.Session
            routie '/cases'
          else
            input.addClass 'inputfield-error'
            message.html("<p>You are not authorized.</p>")
        else
          input.addClass 'inputfield-error'
          for error in data.errors
            html = "<p>* #{error}</p>"
            message.append(html)

### Breadcrumbs

Breadcrumbs is a small helper view which only formats the correct breadcrumbs.

    # views/breadcrumbs.coffee
    class App.Views.Breadcrumbs
      constructor: (data) ->
        a = ''
        for item, i in data
          a += " > " unless i == 0
          a += "<a href='#{item.href}'>#{item.title}</a>"
        return a

##### Example

Breacrumbs are formatted in an array of objects with a title and href.
    
    # views/case_show.coffee
    renderBreadcrumbs: (data) ->
        breadcrumb = [
          {'title': 'All Cases', 'href': '#/cases'}
          {'title': data.title, 'href': "#/cases/#{data.id}"}
        ]
        view = App.Views.Breadcrumbs(breadcrumb)
        @regions.breadcrumbs.html(view)

    # result
    <a href="#/cases">All Cases</a> > <a href="#/cases/2">Platform Driller Borkum</a>

## Utilities

Utilities are located in `app/scripts/`. These classes are only instantiated once, ever. They add some functionality to the framework like showing popup, form validations, cookie management etc.

### Cookies

Cookies are managed by a helper class which sets the correct cookie values based on channel.
Cookies are set with the [cookie monster](https://github.com/jgallen23/cookie-monster) plugin which make it simpler to set and delete.

It currently listens to `cookie:set:sessions` and `cookie:delete:sessions`.

- Default cookie lifetime is 7 days
- Every cookie has a key which corresponds with a session key

##### Example

Sets userId and authToken and then publish these variables, which will result in cookies with the same keys and values.
    
    # views/login.coffee
    App.Session.userId = data.user_id
    App.Session.authToken = data.access_token
    App.Vent.publish 'cookie:set:sessions', App.Session


### Popup

Popup class handles all interaction with popups. It is instantiated on application initialization. It adds a global event listener on `.popup-inline` and `.popup-iframe`. When it is clicked it wil publish an event to some popup channel. Which in turn can be listened to in a view.

##### Example

When the following link is clicked it will publish an event to the following channel `popup:cases/edit` with all the data from the data attributes.
    
    # views/case_index.coffee
    <a class='popup-inline' href='#/cases/edit' data-name='Platform Driller' data-id='1'>Edit Case</a>

Then a popup view is listening to this channel and will display a form in the assigned `#jst-popup` template. After the form is put in the template it will publish an event to `popup:show:inline`.
    
    # views/popup_case.coffee
    App.Vent.subscribe 'popup:cases:edit', @editForm
    
    editForm: (data) =>
      html = "
       ...
      "
      $('#jst-popup').html(html)
      App.Vent.publish 'popup:show:inline'

Popup class will listen to this channel and will display the popup with `$.magnificPopup.open`.

    # utils/popup.coffee
    App.Vent.subscribe 'popup:show:inline', @showInline

    showInline: () ->
      $.magnificPopup.open
      ...

### Forms

Form class handles all events for forms, it is mostly responsible for submitting a form.

This class was made so it would listen to all `form:....` channels. Not automagical! It is more a convention.

##### Example

We listen to `form:cases:edit` and when it gets called it will than attach an event listener to the case edit form. When it gets submitted it will create a model and call the update method with the case_id and all form fields serialized in key/value pairs.

    # utils/form.coffee
    App.Vent.subscribe 'form:cases:edit', @editCase
    ...

    editCase: (data) ->
      App.Vent.subscribe 'model:cases:update', (data) ->
        $.magnificPopup.close()

      $(document.body).off 'submit', '#form-case-edit'
      $(document.body).on 'submit', '#form-case-edit', (e) ->
        m = new App.Models.Case
        e.preventDefault()
        m.update data.case_id, $(this).serializeObject()
