Route = require './route'

class ResourceRoutes
  constructor: (@path, @name) ->

  indexRoute: ->
    new Route
      path: "#{@path}#{@name}"
      method: 'GET'
      controller: @name
      action: 'index'

  newRoute: ->
    new Route
      path: "#{@path}#{@name}/new"
      method: 'GET'
      controller: @name
      action: 'new'

  createRoute: ->
    new Route
      path: "#{@path}#{@name}"
      method: 'POST'
      controller: @name
      action: 'create'

  showRoute: ->
    new Route
      path: "#{@path}#{@name}/:id"
      method: 'GET'
      controller: @name
      action: 'show'

  editRoute: ->
    new Route
      path: "#{@path}#{@name}/:id/edit"
      method: 'GET'
      controller: @name
      action: 'edit'

  updateRoute: ->
    new Route
      path: "#{@path}#{@name}/:id"
      method: 'PUT'
      controller: @name
      action: 'update'

  destroyRoute: ->
    new Route
      path: "#{@path}#{@name}/:id"
      method: 'DELETE'
      controller: @name
      action: 'destroy'

module.exports = ResourceRoutes
