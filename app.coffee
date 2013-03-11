connect = require 'connect'
Url = require 'url'
Application = require './config/routes'

app = connect().
  use(connect.logger('dev')).
  use(connect.static('public')).
  use (req, res)->
    res.setHeader('content-type', 'text/html')
    url = Url.parse(req.url)
    routes = Application.routes.mapper.allRoutes().filter (route)->
      route.matches(url.pathname, req.method)
    if routes.length > 0
      route = routes[0]
      controllerPath = "./app/controllers/#{route.controller}Controller"
      Controller = uncachedRequire controllerPath
      c = new Controller(req, res, route.paramsHash(url))
      c[route.action]()

    else
      res.end('route not found')


global.uncachedRequire = (file) ->
  cachedFile = require.resolve(file)
  delete require.cache[cachedFile]
  require file

port = 3000

app.listen(port)

console.log "Listening on port #{port}"

Application.routes.mapper.print()
