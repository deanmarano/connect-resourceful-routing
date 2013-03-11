class HTTPActionRoutes
  constructor: (@path, @controller) ->

  getRoute: (action) ->
    new Route
      method: 'GET'
      path: @path + '/' + action
      controller: @controller
      action: action

  postRoute: (action) ->
    new Route
      method: 'POST'
      path: @path + '/' + action
      controller: @controller
      action: action

  putRoute: (action) ->
    new Route
      method: 'PUT'
      path: @path + '/' + action
      controller: @controller
      action: action

  deleteRoute: (action) ->
    new Route
      method: 'DELETE'
      path: @path + '/' + action
      controller: @controller
      action: action



module.exports = HTTPActionRoutes
