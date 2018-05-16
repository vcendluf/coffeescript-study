class TodoApp
    constructor: ->
        @bindEvents()

    bindEvents: ->
        alert 'binding events'

$ -> 
    app = new TodoApp()