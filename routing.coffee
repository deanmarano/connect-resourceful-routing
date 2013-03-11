require './inflector'
Route = require './route'
ResourceRoutes = require './resourceRoutes'
HTTPActionRoutes = require './httpActionRoutes'

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
    @_httpActionRoutes = new HTTPActionRoutes(@path, @controller)
    fn.call(@, fn)
    @

  member: (controller, fn)->
    @controller = controller
    @_httpActionRoutes = new HTTPActionRoutes(@path, @controller)
    fn.call(@, fn)
    @

  post: (action)->
    @routes.push @_httpActionRoutes.postRoute(action)

  get: (action)->
    @routes.push @_httpActionRoutes.getRoute(action)

  put: (action)->
    @routes.push @_httpActionRoutes.putRoute(action)

  delete: (action)->
    @routes.push @_httpActionRoutes.deleteRoute(action)

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
      console.log route.toString(max)

class Resource
  constructor: (@parent, @name, @path, @options = {})->
    @routes = @generateRoutes()
    @resourceMappers = []

  generateRoutes: ->
    resourceRoutes = new ResourceRoutes(@path, @name)
    routes = [
      resourceRoutes.newRoute(),
      resourceRoutes.createRoute(),
      resourceRoutes.showRoute(),
      resourceRoutes.editRoute(),
      resourceRoutes.updateRoute(),
      resourceRoutes.destroyRoute()
    ]

    routes.push(resourceRoutes.indexRoute()) if @options.include == 'index'
    routes

  resources: (name, fn)->
    resourcePath = @path + @name + "/:#{@name.singularize()}Id"
    mapper = new Mapper(@parent, resourcePath + '/')
    @resourceMappers.push mapper.resources(name, fn)

  collection: (fn)->
    collectionPath = @path + @name
    @collectionMapper = new Mapper(@parent, collectionPath)
    @collectionMapper.collection(@name, fn)

  member: (fn)->
    memberPath = @path + @name + "/:id"
    @memberMapper = new Mapper(@parent, memberPath)
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
