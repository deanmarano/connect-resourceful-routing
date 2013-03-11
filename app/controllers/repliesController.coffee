class RepliesController
  constructor: (@request, @response, @params)->

  index: ->
    @response.end('hello from replies controller#index')

  show: ->
    @response.end("hello from replies controller#show. Called with params #{JSON.stringify(@params)}")

module.exports = RepliesController
