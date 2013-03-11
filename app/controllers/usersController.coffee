class RepliesController
  constructor: (@request, @response, @params)->

  index: ->
    @response.end('hello from users controller#index')

  show: ->
    @response.end("hello from users controller#show. Called with params #{JSON.stringify(@params)}")

module.exports = RepliesController
