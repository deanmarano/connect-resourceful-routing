class PostsController
  constructor: (@request, @response, @params)->

  index: ->
    @response.end('hello from posts controller#index')

  new: ->
    @response.end('hello from posts controller#new')

  show: ->
    @response.end("hello from posts controller#show. Called with params #{JSON.stringify(@params)}")

  edit: ->
    @response.end("hello from posts controller#edit. Called with params #{JSON.stringify(@params)}")

  upvote: ->
    @response.end("hello from posts controller#upvote. Called with params #{JSON.stringify(@params)}")

module.exports = PostsController
