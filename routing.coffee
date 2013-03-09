require './inflector'

p = (str)-> console.log(str)

class Route
  constructor: (options)->
    @method = options.method
    @path = options.path
    @controller = options.controller
    @action = options.action

  toString: ->
    switch @method
      when 'get' then method = "GET    "
      when 'put' then method = "PUT    "
      when 'delete' then method = "DELETE "
      when 'post' then method = "POST   "
    pathPad = Array(40 - @path.length).join(" ")
    "#{method} #{@path}#{pathPad}to: #{@controller}##{@action}"

class Mapper
  constructor: (@parent, @path)->
    @nestedResources = []
    @routes = []

  resources: (name, fn)->
    resource = new Resource(@, name, @path)
    @nestedResources.push(resource)
    if fn
      fn.call(resource, fn)
    resource

  collection: (controller, fn)->
    @controller = controller
    fn.call(@, fn)
    @

  member: (controller, fn)->
    @controller = controller
    fn.call(@, fn)
    @

  post: (action)->
    @routes.push new Route
      method: 'post'
      path: @path + '/' + action
      controller: @controller
      action: action

  get: (action)->
    @routes.push new Route
      method: 'get'
      path: @path + '/' + action
      controller: @controller
      action: action

  put: (action)->
    @routes.push new Route
      method: 'put'
      path: @path + '/' + action
      controller: @controller
      action: action

  delete: (action)->
    @routes.push new Route
      method: 'delete'
      path: @path + '/' + action
      controller: @controller
      action: action

  parentPath: ->
    if @parent
      @parent.path
    else
      '/'

  root: (options)->
    [controller, action] = options.to.split("#")
    @routes.push new Route
      method: 'get'
      path: '/'
      controller: controller
      action: action

  allRoutes: ->
    r = @routes.slice(0, @routes.length)
    for resource in @nestedResources
      r = r.concat resource.allRoutes()
    r

  print: ->
    for route in @allRoutes()
      p route.toString()

class Resource
  constructor: (@parent, name, @path)->
    @name = name#.pluralize()
    @routes = @generateRoutes()
    @resourceMappers = []

  generateRoutes: ->
    [
      @indexRoute(),
      @newRoute(),
      @createRoute(),
      @showRoute(),
      @editRoute(),
      @updateRoute(),
      @destroyRoute()
    ]

  indexRoute: ->
    new Route
      path: "#{@path}#{@name}"
      method: 'get'
      controller: @name
      action: 'index'

  newRoute: ->
    new Route
      path: "#{@path}#{@name}/new"
      method: 'get'
      controller: @name
      action: 'new'

  createRoute: ->
    new Route
      path: "#{@path}#{@name}"
      method: 'post'
      controller: @name
      action: 'create'

  showRoute: ->
    new Route
      path: "#{@path}#{@name}/:id"
      method: 'get'
      controller: @name
      action: 'show'

  editRoute: ->
    new Route
      path: "#{@path}#{@name}/:id/edit"
      method: 'get'
      controller: @name
      action: 'edit'

  updateRoute: ->
    new Route
      path: "#{@path}#{@name}/:id"
      method: 'put'
      controller: @name
      action: 'update'

  destroyRoute: ->
    new Route
      path: "#{@path}#{@name}/:id"
      method: 'delete'
      controller: @name
      action: 'destroy'

  resources: (name, fn)->
    resourcePath = @path + @name + '/'
    mapper = new Mapper(@parent, @memberPath() + '/')
    @resourceMappers.push mapper.resources(name, fn)

  memberPath: ->
    @path + @name + "/:#{@name.singularize()}_id"

  collection: (fn)->
    @collectionMapper = new Mapper(@parent, @path + @name)
    @collectionMapper.collection(@name, fn)

  member: (fn)->
    @memberMapper = new Mapper(@parent, @memberPath())
    @memberMapper.member(@name, fn)

  allRoutes: ->
    r = @routes.slice(0, @routes.length)
    for resource in @resourceMappers
      r = r.concat resource.allRoutes()
    if @collectionMapper?
      r = r.concat @collectionMapper.allRoutes()
    if @memberMapper?
      r = r.concat @memberMapper.allRoutes()
    r

Application =
  routes:
    draw: (fn)->
      @mapper = new Mapper(null, '/')
      fn.call(@mapper, fn)

Application.routes.draw ->
  @resources 'deals', ->
    @collection ->
      @post 'import'
    @member ->
      @get 'status'

    @resources 'options', ->

  @root
    to: 'deals#index'

#Application.routes.mapper.print()

module.exports = Application
