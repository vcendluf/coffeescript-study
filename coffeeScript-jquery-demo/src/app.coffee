Storage::setObj = (key, obj) ->
    @setItem key, JSON.stringify(obj)

Storage::getObj = (key) ->
    JSON.parse @getItem(key)

class TodoApp
    constructor: ->
        @cacheElements()
        @bindEvents()
        @displayItems()
    
    cacheElements: ->
        @$input = $('#new-todo')
        @$todoList = $('#todo-list')

    bindEvents: ->
        @$input.on('keyup', (e) => @create(e))
        # $('#new-todo').on('keyup', (e) => @create(e))

    create: (e) ->
        # $input = $(this)
        # $input = $(e.target)
        val = ($.trim @$input.val())
        return unless e.which == 13 and val

        randomId = (Math.floor Math.random()*999999)

        localStorage.setObj randomId, {
            id: randomId
            title: val
            completed: false
        }
        @$input.val ''
        @displayItems()
        # alert val
        # We create the todo item

    displayItems: ->
        @clearItems()
        @addItem(localStorage.getObj(id)) for id in Object.keys(localStorage)
        # alert 'displaying items'
    
    clearItems: ->
        @$todoList.empty()

    addItem: (item) ->
        html = """
            <li #{if item.completed then 'class="completed"' else ''} data-id="#{item.id}">
                <div class="view">
                    <input class="toggle" type="checkbox" #{if item.completed then 'checked' else ''} />
                    <label>#{item.title}</label>
                    <button class="destroy"></button>
                </div>
            </li>
        """
        @$todoList.append(html)

$ -> 
    app = new TodoApp()