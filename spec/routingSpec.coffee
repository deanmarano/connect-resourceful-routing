Application = require '../routing'

describe 'Routing', ->
  describe 'resources', ->
    beforeEach ->
      Application.routes.draw ->
        @resources 'posts'

    it 'creates the 7 routes for resources', ->
      routes = Application.routes.mapper.allRoutes()
      expect(routes.length).toBe(7)

    it 'creates the index route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'index'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the new route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'new'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/new')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the create route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'create'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('POST')

    it 'creates the show route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'show'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the edit route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'edit'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id/edit')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the update route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'update'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('PUT')

    it 'creates the destroy route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'destroy'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('DELETE')

  describe 'resource', ->
    beforeEach ->
      Application.routes.draw ->
        @resource 'posts'

    it 'creates the 6 routes for resources', ->
      routes = Application.routes.mapper.allRoutes()
      expect(routes.length).toBe(6)

    it 'creates the new route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'new'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/new')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the create route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'create'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('POST')

    it 'creates the show route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'show'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the edit route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'edit'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id/edit')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the update route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'update'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('PUT')

    it 'creates the destroy route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'destroy'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('DELETE')

  describe 'resource collection', ->
    beforeEach ->
      Application.routes.draw ->
        @resource 'posts'

    it 'creates the 6 routes for resources', ->
      routes = Application.routes.mapper.allRoutes()
      expect(routes.length).toBe(6)

    it 'creates the new route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'new'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/new')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the create route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'create'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('POST')

    it 'creates the show route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'show'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the edit route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'edit'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id/edit')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('GET')

    it 'creates the update route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'update'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('PUT')

    it 'creates the destroy route', ->
      routes = Application.routes.mapper.allRoutes()
      indexRoute = routes.filter (route) -> route.action == 'destroy'
      expect(indexRoute.length).toBe(1)
      indexRoute = indexRoute[0]
      expect(indexRoute.path).toBe('/posts/:id')
      expect(indexRoute.controller).toBe('posts')
      expect(indexRoute.method).toBe('DELETE')
