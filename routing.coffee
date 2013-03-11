require './inflector'
Route = require './route'

p = (str)-> console.log(str)

class Mapper
  constructor: (@parent, @path)->
    @nestedResources = []
    @routes = []

  resources: (name, fn)->
    resource = new Resource(@, name, @path, include: 'index')
    @nestedResources.push(resource)
    if fn
      fn.call(resource, fn)
    resource

  resource: (name, fn)->
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
    max = 0
    for route in @allRoutes()
      max = route.path.length if route.path.length > max
    for route in @allRoutes()
      p route.toString(max)

class Resource
  constructor: (@parent, name, @path, @options = {})->
    @name = name#.pluralize()
    @routes = @generateRoutes()
    @resourceMappers = []

  generateRoutes: ->
    routes = [
      @newRoute(),
      @createRoute(),
      @showRoute(),
      @editRoute(),
      @updateRoute(),
      @destroyRoute()
    ]

    if @options.include == 'index'
      routes.push(@indexRoute())
    routes

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
    mapper = new Mapper(@parent, @resourcePath() + '/')
    @resourceMappers.push mapper.resources(name, fn)

  resourcePath: ->
    @path + @name + "/:#{@name.singularize()}Id"

  memberPath: ->
    @path + @name + "/:id"

  collection: (fn)->
    @collectionMapper = new Mapper(@parent, @path + @name)
    @collectionMapper.collection(@name, fn)

  member: (fn)->
    @memberMapper = new Mapper(@parent, @memberPath())
    @memberMapper.member(@name, fn)

  allRoutes: ->
    r = @routes.slice(0, @routes.length)
    if @memberMapper?
      r = @memberMapper.allRoutes().concat r
    for resource in @resourceMappers
      r = r.concat resource.allRoutes()
    if @collectionMapper?
      r = r.concat @collectionMapper.allRoutes()
    r

Application =
  routes:
    draw: (fn)->
      @mapper = new Mapper(null, '/')
      fn.call(@mapper, fn)

module.exports = Application
