Route = require '../route'

describe 'Route', ->
  it 'initializes from options', ->
    options =
      method: 'GET'
      path: '/posts'
      controller: 'posts'
      action: 'index'
    route = new Route(options)
    expect(route.method).toBe('GET')
    expect(route.path).toBe('/posts')
    expect(route.controller).toBe('posts')
    expect(route.action).toBe('index')

  it 'generates a proper regex for basic resources index', ->
    options =
      method: 'GET'
      path: '/posts'
      controller: 'posts'
      action: 'index'
    route = new Route(options)
    expect(route.matches('/posts', 'GET')).toBe(true)

  it 'generates a proper regex for basic resources show', ->
    options =
      method: 'GET'
      path: '/posts/:id'
      controller: 'posts'
      action: 'show'
    route = new Route(options)
    expect(route.matches('/posts/13', 'GET')).toBe(true)
    expect(route.paramsHash(pathname: '/posts/13').id).toBe('13')

  it 'generates a proper regex for basic resources edit', ->
    options =
      method: 'GET'
      path: '/posts/:id/edit'
      controller: 'posts'
      action: 'edit'
    route = new Route(options)
    expect(route.matches('/posts/13/edit', 'GET')).toBe(true)
    expect(route.paramsHash(pathname: '/posts/13/edit').id).toBe('13')

  it 'generates a proper regex for a nested resource', ->
    options =
      method: 'GET'
      path: '/posts/:postId/replies/:id'
      controller: 'posts'
      action: 'edit'
    route = new Route(options)
    expect(route.matches('/posts/13/replies/12', 'GET')).toBe(true)
    expect(route.paramsHash(pathname: '/posts/13/replies/12').id).toBe('12')
    expect(route.paramsHash(pathname: '/posts/13/replies/12').postId).toBe('13')

  it 'handles member actions', ->
    options =
      method: 'GET'
      path: '/posts/:id/upvote'
      controller: 'posts'
      action: 'upvote'
    route = new Route(options)
    expect(route.matches('/posts/13/upvote', 'GET')).toBe(true)
    expect(route.paramsHash(pathname: '/posts/13/upvote').id).toBe('13')
